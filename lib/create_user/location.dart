import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/input.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';

class CreateUserLocation extends HookConsumerWidget {
  const CreateUserLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUser = ref.read(userProvider.notifier).updateUser;
    final location = useState('');

    onNext() {
      //updateUser(User(cognito_id: '', location: location.value));
      Navigator.pushNamed(context, 'create/profile_pic');
    }

    return CreateUserLayout(
        active: 3,
        title: 'LOCATION',
        subtitle: "Where are you located?",
        child: Form(
            child: Column(
          children: [
            CreateInput(
              label: 'Zip Code',
              onChange: (value) {
                location.value = value;
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
