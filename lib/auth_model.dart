import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';

@immutable
class AuthModel {
  static Future<bool> isUserSignedIn() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      return result.isSignedIn;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<AuthUser> getCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return AuthUser(userId: '', username: '');
    }
  }

  static Future<AuthUser> signInWithGoogle() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      return await AuthModel.getCurrentUser();
    } on AmplifyException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  static Future<bool> logout() async {
    try {
      await Amplify.Auth.signOut();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
