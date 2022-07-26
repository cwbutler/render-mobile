import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/screens/create_user/layout.dart';
import 'package:render/screens/create_user/input.dart';
import 'package:render/screens/create_user/next_button.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';

class CreateUserProfessional extends HookConsumerWidget {
  const CreateUserProfessional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;

    onNext() {
      Navigator.pushNamed(context, 'create/location');
    }

    return CreateUserLayout(
        active: 2,
        title: 'PROFESSIONAL',
        subtitle: "Let's gather some professional info",
        child: Form(
            child: Column(
          children: [
            CreateInput(
              label: 'LinkedIn Profile',
              onChange: (value) {
                updateUser(UserProfile(linkedin_profile: value));
              },
            ),
            CreateInput(
              label: 'Personal Website/Github',
              onChange: (value) {
                updateUser(UserProfile(website: value));
              },
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: NextButton(onPressed: onNext))
          ],
        )));
  }
}