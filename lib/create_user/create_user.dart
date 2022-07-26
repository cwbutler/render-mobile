import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/input.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';

class CreateUser extends HookConsumerWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).user;
    final updateUser = ref.read(userProvider.notifier).updateUser;

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
            initalText: user?.displayName?.split(" ")[0],
            onChange: (value) {
              //updateUser(User(cognito_id: '', first_name: value));
            },
          ),
          CreateInput(
            label: 'Last Name',
            initalText: user?.displayName?.split(" ")[1],
            onChange: (value) {
              //updateUser(User(cognito_id: '', last_name: value));
            },
          ),
          CreateInput(
              label: 'Email',
              initalText: user?.email,
              onChange: (value) {
                //updateUser(User(cognito_id: '', email: value));
              },
              keyboardType: TextInputType.emailAddress),
          CreateInput(
            label: 'Phone',
            initalText: user?.phoneNumber,
            keyboardType: TextInputType.phone,
            onChange: (value) {
              //updateUser(User(cognito_id: '', phone_number: value));
            },
          ),
          const Spacer(),
          NextButton(onPressed: onNext)
        ]));
  }
}
