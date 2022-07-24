import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/input.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user.dart';

class CreateUser extends HookConsumerWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUser = ref.read(userProvider.notifier).updateUser;
    final firstName = useState('');
    final lastName = useState('');
    final email = useState('');
    final phone = useState('');

    onNext() {
      updateUser(User(
          email: email.value,
          first_name: firstName.value,
          last_name: lastName.value,
          phone: phone.value));
      Navigator.pushNamed(context, 'create/professional');
    }

    return CreateUserLayout(
        active: 1,
        title: 'PROFESSIONAL',
        subtitle: "Let's gather some professional info",
        child: Column(children: [
          CreateInput(
            label: 'First Name',
            onChange: (value) {
              firstName.value = value;
            },
          ),
          CreateInput(
            label: 'Last Name',
            onChange: (value) {
              lastName.value = value;
            },
          ),
          CreateInput(
              label: 'Email',
              onChange: (value) {
                email.value = value;
              },
              keyboardType: TextInputType.emailAddress),
          CreateInput(
            label: 'Phone',
            keyboardType: TextInputType.phone,
            onChange: (value) {
              phone.value = value;
            },
          ),
          const Spacer(),
          NextButton(onPressed: onNext)
        ]));
  }
}
