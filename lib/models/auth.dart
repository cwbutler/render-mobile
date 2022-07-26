// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:render/firebase_options.dart';
import 'package:render/models/user_profile.dart';

@immutable
class RenderUser {
  final User? user;
  final UserProfile userProfile;
  final bool? hasProfile;

  const RenderUser({
    this.user,
    this.userProfile = const UserProfile(),
    this.hasProfile = false,
  });

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
        .signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  RenderUser copyWith(RenderUser user) {
    return RenderUser(
      user: user.user ?? this.user,
      userProfile: userProfile.copyWith(user.userProfile),
      hasProfile: user.hasProfile ?? hasProfile,
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
        );

        return copyWith(RenderUser(userProfile: profile, hasProfile: true));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return copyWith(
      RenderUser(
        userProfile: UserProfile(
          id: user?.uid,
          email: user?.email,
          first_name: user?.displayName?.split(" ")[0],
          last_name: user?.displayName?.split(" ")[1],
          phone: user?.phoneNumber,
          profile_photo_url: user?.photoURL,
        ),
      ),
    );
  }

  Future<void> saveUserProfile() async {
    try {
      final db = FirebaseFirestore.instance;
      await db
          .collection("users")
          .doc(user?.uid)
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
}

final userProvider = StateNotifierProvider<UserNotifier, RenderUser>((ref) {
  return UserNotifier(const RenderUser());
});
