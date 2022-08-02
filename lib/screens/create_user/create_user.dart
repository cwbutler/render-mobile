import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/screens/create_user/layout.dart';
import 'package:render/components/input.dart';
import 'package:render/screens/create_user/next_button.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';

class CreateUser extends HookConsumerWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;
    final canSave = user.first_name != null &&
        user.last_name != null &&
        user.email != null &&
        user.phone != null;

    onNext() {
      Navigator.pushNamed(context, 'create/professional');
    }

    return CreateUserLayout(
        active: 1,
        title: 'PROFESSIONAL',
        subtitle: "Let's gather some professional info",
        child: Column(children: [
          CreateInput(
            label: 'First Name',
            initalText: user.first_name,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            onChange: (value) {
              updateUser(UserProfile(first_name: value));
            },
          ),
          CreateInput(
            label: 'Last Name',
            initalText: user.last_name,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            onChange: (value) {
              updateUser(UserProfile(last_name: value));
            },
          ),
          CreateInput(
            label: 'Email',
            initalText: user.email,
            onChange: (value) {
              updateUser(UserProfile(email: value));
            },
            keyboardType: TextInputType.emailAddress,
          ),
          CreateInput(
            label: 'Phone',
            initalText: user.phone,
            keyboardType: TextInputType.phone,
            onChange: (value) {
              updateUser(UserProfile(phone: value));
            },
          ),
          const Spacer(),
          NextButton(onPressed: (canSave) ? onNext : null),
        ]));
  }
}
