import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/create_user/layout.dart';
import 'package:render/create_user/next_button.dart';
import 'package:render/models/auth.dart';
//import 'package:render/models/user.dart';

class CreateUserProfilePic extends HookConsumerWidget {
  const CreateUserProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final updateUser = ref.read(userProvider.notifier).updateUser;
    final image = useState('');

    onNext() {
      //AuthModel.saveUser(user.copyWith(createdAt: TemporalDateTime.now()));
      Navigator.pushNamed(context, 'home');
    }

    onSkip() {
      //AuthModel.saveUser(user.copyWith(createdAt: TemporalDateTime.now()));
      Navigator.pushNamed(context, 'home');
    }

    return CreateUserLayout(
        active: 4,
        title: 'PROFILE PIC',
        subtitle: "Add a profile picture...or don’t",
        child: Form(
            child: Column(
          children: [
            const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 52,
                child: CircleAvatar(
                    radius: 50, backgroundColor: Color(0xffFF88DF))),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: NextButton(onPressed: onNext, title: 'FINISH')),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: onSkip,
                  child: const Text('Add later',
                      style: TextStyle(
                          color: Color(0xffFF88DF),
                          fontFamily: 'Gothic A1',
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ))
          ],
        )));
  }
}
