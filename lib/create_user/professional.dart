import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/input.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';

class CreateUserProfessional extends HookConsumerWidget {
  const CreateUserProfessional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUser = ref.read(userProvider.notifier).updateUser;
    final linkedin = useState('');
    final website = useState('');
    final resume = useState('');

    onNext() {
      /*updateUser(User(
          cognito_id: '',
          linkedin_profile: linkedin.value,
          website: website.value,
          resume: resume.value));*/
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
                linkedin.value = value;
              },
            ),
            CreateInput(
              label: 'Personal Website/Github',
              onChange: (value) {
                website.value = value;
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
