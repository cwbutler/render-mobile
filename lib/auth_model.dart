import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:render/models/user.dart';

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

  static Future<User> getCurrentUser() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final userProfile = await AuthModel.getUserProfile(user);
      return userProfile;
    } catch (e) {
      debugPrint(e.toString());
      return User(email: '', id: '');
    }
  }

  static Future<User> signInWithGoogle() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      return await AuthModel.getCurrentUser();
    } on AmplifyException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<bool> logout() async {
    try {
      await Amplify.Auth.signOut();
      await Amplify.DataStore.clear();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<User> getUserProfile(AuthUser user) async {
    try {
      List<User> users = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(user.userId));
      if (users.isNotEmpty) {
        return users[0];
      } else {
        return User(email: user.username, id: user.userId);
      }
    } catch (e) {
      debugPrint("Could not query DataStore: $e");
      return User(email: '', id: '');
    }
  }
}
