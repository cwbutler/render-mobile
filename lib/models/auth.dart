// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:render/firebase_options.dart';
import 'package:render/models/user_profile.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

@immutable
class RenderUser {
  final User? user;
  final UserProfile userProfile;
  final bool hasProfile;

  const RenderUser({
    this.user,
    this.userProfile = const UserProfile(),
    this.hasProfile = false,
  });

  RenderUser copyWith(RenderUser user) {
    return RenderUser(
      user: user.user ?? this.user,
      userProfile: userProfile.copyWith(user.userProfile),
      hasProfile: user.hasProfile,
    );
  }

  Future<void> saveUserProfile() async {
    try {
      final db = FirebaseFirestore.instance;
      await db
          .collection("users")
          .doc(userProfile.id)
          .set(userProfile.toMap(), SetOptions(merge: true))
          .onError((error, stackTrace) => debugPrint(error.toString()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class UserNotifier extends StateNotifier<RenderUser> {
  UserNotifier(RenderUser state) : super(state);

  void setCurrentUser(RenderUser user) {
    state = user;
  }

  RenderUser updateUserProfile(UserProfile profile) {
    state = state.copyWith(RenderUser(userProfile: profile));
    return state;
  }

  void clearUser() {
    state = const RenderUser();
  }

  Future<RenderUser> fetchCurrentUser() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final user = RenderUser(user: FirebaseAuth.instance.currentUser);
        state = state.copyWith(user);
        await getUserProfile();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }

  Future<RenderUser> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: AppleIDAuthorizationScopes.values,
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      await fetchCurrentUser();
      return state;
    } catch (e) {
      debugPrint(e.toString());
    }

    return state;
  }

  Future<RenderUser> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
      ).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      await fetchCurrentUser();
      return state;
    } catch (e) {
      debugPrint(e.toString());
    }

    return state;
  }

  Future<void> deleteUser() async {
    try {
      final db = FirebaseFirestore.instance;
      await db.collection("users").doc(state.userProfile.id).delete();

      if (state.userProfile.resume_url != null &&
          state.userProfile.resume_url!.isNotEmpty) {
        final key =
            'resumes/${state.userProfile.id}_${state.userProfile.resume_name}';
        await FirebaseStorage.instance.ref(key).delete();
      }

      if (state.userProfile.profile_photo_url != null &&
          state.userProfile.profile_photo_url!.isNotEmpty) {
        final key = 'images/${state.userProfile.id}';
        await FirebaseStorage.instance.ref(key).delete();
      }

      await FirebaseFirestore.instance.clearPersistence();

      await logout();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    clearUser();
  }

  Future<RenderUser> getUserProfile() async {
    try {
      final db = FirebaseFirestore.instance;
      final result = await db.collection("users").doc(state.user?.uid).get();

      if (result.exists) {
        final data = result.data() as Map<String, dynamic>;
        final profile = UserProfile(
          id: data["id"],
          email: data["email"],
          first_name: data["first_name"],
          last_name: data["last_name"],
          phone: data["phone"],
          linkedin_profile: data["linkedin_profile"],
          website: data["website"],
          location: data["location"],
          profile_photo_url: data["profile_photo_url"],
          resume_name: data["resume_name"],
          resume_url: data["resume_url"],
          isNotificationsEnabled: data["isNotificationsEnabled"],
        );

        final user = RenderUser(userProfile: profile, hasProfile: true);
        state = state.copyWith(user);
        return user;
      } else if (state.user != null && state.user!.uid.isNotEmpty) {
        final name = state.user?.displayName?.split(" ");
        final user = RenderUser(
          hasProfile: false,
          userProfile: UserProfile(
            id: state.user?.uid,
            email: state.user?.email,
            first_name: name?[0],
            last_name: name?[1],
            phone: state.user?.phoneNumber,
            profile_photo_url: state.user?.photoURL,
          ),
        );
        state = state.copyWith(user);
        return user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    state = state.copyWith(const RenderUser(hasProfile: false));
    return state;
  }

  Future<RenderUser> saveUserResume({
    required String fileName,
    required File file,
  }) async {
    try {
      final key = 'resumes/${state.userProfile.id}';
      final storageRef = FirebaseStorage.instance.ref(key);
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      state = state.copyWith(RenderUser(
        userProfile: UserProfile(
          resume_url: url,
          resume_name: fileName,
        ),
      ));
      return state;
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }

  Future<RenderUser> saveUserImage({required File file}) async {
    try {
      final key = 'images/${state.userProfile.id}';
      final storageRef = FirebaseStorage.instance.ref(key);
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      state = state.copyWith(
        RenderUser(userProfile: UserProfile(profile_photo_url: url)),
      );
      return state;
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, RenderUser>((ref) {
  return UserNotifier(const RenderUser());
});
