import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user.dart';

class CreateUserProfilePic extends HookConsumerWidget {
  const CreateUserProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateUser = ref.read(userProvider.notifier).updateUser;
    final image = useState('');

    onNext() {
      updateUser(User(email: '', profile_picture: image.value));
    }

    onSkip() {}

    return CreateUserLayout(
        active: 4,
        title: 'PROFILE PIC',
        subtitle: "Add a profile picture...or don’t",
        child: Form(
            child: Column(
          children: [
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: NextButton(onPressed: onNext, title: 'FINISH')),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: onSkip,
                  child: const Text('Add later'),
                ))
          ],
        )));
  }
}
