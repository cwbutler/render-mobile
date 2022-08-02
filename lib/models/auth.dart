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

  Future<UserCredential> signInWithApple() async {
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
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      debugPrint(e.toString());
    }

    throw "Could not sign in";
  }

  Future<UserCredential> signInWithGoogle() async {
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
      final UserCredential creds =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return creds;
    } catch (e) {
      debugPrint(e.toString());
    }

    throw "Could not sign in";
  }

  Future<void> deleteUser() async {
    try {
      final db = FirebaseFirestore.instance;
      await db.collection("users").doc(userProfile.id).delete();

      if (userProfile.resume_url != null &&
          userProfile.resume_url!.isNotEmpty) {
        final key = 'resumes/${userProfile.id}_${userProfile.resume_name}';
        await FirebaseStorage.instance.ref(key).delete();
      }

      if (userProfile.profile_photo_url != null &&
          userProfile.profile_photo_url!.isNotEmpty) {
        final key = 'images/${userProfile.id}';
        await FirebaseStorage.instance.ref(key).delete();
      }

      await logout();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  RenderUser copyWith(RenderUser user) {
    return RenderUser(
      user: user.user ?? this.user,
      userProfile: userProfile.copyWith(user.userProfile),
      hasProfile: user.hasProfile,
    );
  }

  Future<RenderUser> getUserProfile() async {
    try {
      final db = FirebaseFirestore.instance;
      final result = await db.collection("users").doc(user?.uid).get();

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

        return copyWith(RenderUser(
          userProfile: profile,
          hasProfile: true,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return RenderUser(user: user, userProfile: userProfile, hasProfile: false);
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

  Future<String> saveUserResume({
    required String fileName,
    required File file,
  }) async {
    try {
      final key = 'resumes/${userProfile.id}_$fileName';
      final storageRef = FirebaseStorage.instance.ref(key);
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  Future<String> saveUserImage({required File file}) async {
    try {
      final key = 'images/${userProfile.id}';
      final storageRef = FirebaseStorage.instance.ref(key);
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
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

  Future<RenderUser> signInWithGoogle() async {
    try {
      final creds = await state.signInWithGoogle();
      final appUser = await RenderUser(user: creds.user).getUserProfile();

      if (appUser.hasProfile) {
        state = appUser;
      } else {
        final name = appUser.user?.displayName?.split(" ");
        final profile = UserProfile(
          id: appUser.user?.uid,
          first_name: name?[0],
          last_name: name?[1],
          email: appUser.user?.email,
          phone: appUser.user?.phoneNumber,
          profile_photo_url: appUser.user?.photoURL,
        );
        state = state.copyWith(RenderUser(userProfile: profile));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }

  Future<RenderUser> signInWithApple() async {
    try {
      final creds = await state.signInWithApple();
      final appUser = await RenderUser(user: creds.user).getUserProfile();

      if (appUser.hasProfile) {
        state = appUser;
      } else {
        final name = appUser.user?.displayName?.split(" ");
        final profile = UserProfile(
          id: appUser.user?.uid,
          first_name: name?[0],
          last_name: name?[1],
          email: appUser.user?.email,
        );
        state = appUser.copyWith(RenderUser(userProfile: profile));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }

  Future<RenderUser> fetchCurrentUser() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final user = RenderUser(user: FirebaseAuth.instance.currentUser);
        state = await user.getUserProfile();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return state;
  }

  Future<void> deleteUser() async {
    try {
      await state.deleteUser();
      state = const RenderUser();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, RenderUser>((ref) {
  return UserNotifier(const RenderUser());
});
