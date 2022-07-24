// ignore_for_file: non_constant_identifier_names

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier(User state) : super(state);

  void setCurrentUser(User user) {
    state = user;
  }

  void updateUser(User user) {
    state = state.copyWith(
        email: (user.email == '') ? state.email : user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        phone: user.phone,
        linkedin_profile: user.linkedin_profile,
        website: user.website,
        resume: user.resume,
        profile_picture: user.profile_picture);
  }

  void clearUser() {
    state = User(email: '', id: '');
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier(User(email: ''));
});
