import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/screens/create_user/layout.dart';
import 'package:render/components/input.dart';
import 'package:render/screens/create_user/next_button.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';

class CreateUserLocation extends HookConsumerWidget {
  const CreateUserLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProvider).userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;

    onNext() {
      Navigator.pushNamed(context, 'create/profile_pic');
    }

    return CreateUserLayout(
      active: 3,
      title: 'LOCATION',
      subtitle: "Where are you located?",
      child: Column(
        children: [
          CreateInput(
            label: 'Zip Code',
            initalText: profile.location,
            keyboardType: TextInputType.number,
            onChange: (value) {
              updateUser(UserProfile(location: value));
            },
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: NextButton(
              onPressed:
                  (profile.location != null && profile.location!.isNotEmpty)
                      ? onNext
                      : null,
            ),
          )
        ],
      ),
    );
  }
}
