import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class RenderUser {
  const RenderUser({this.user});

  final AuthUser? user;
}

class UserNotifier extends StateNotifier<RenderUser> {
  UserNotifier(RenderUser state) : super(state);

  setCurrentUser(RenderUser user) {
    state = user;
  }

  void clearUser() {
    state = const RenderUser(user: null);
  }
}

final userProvider = StateNotifierProvider((ref) {
  return UserNotifier(const RenderUser(user: null));
});
