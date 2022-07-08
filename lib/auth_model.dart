import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';

@immutable
class AuthModel {
  static Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  static Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  static void logout() async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
