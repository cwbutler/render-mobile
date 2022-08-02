import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/auth.dart';
import 'package:render/screens/login/button.dart';

class LoginBody extends HookConsumerWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInWithGoogle = ref.read(userProvider.notifier).signInWithGoogle;
    final signInWithApple = ref.read(userProvider.notifier).signInWithApple;

    navigateAway(RenderUser user) {
      if (user.user == null) return;
      final nextRoute = (user.hasProfile) ? 'home' : 'create';
      Navigator.popAndPushNamed(context, nextRoute);
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 150, 0, 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/logo.png')),
            const Spacer(),
            LoginBtn(
              text: "CONTINUE WITH APPLE",
              icon: 'assets/svgs/apple_logo.svg',
              onPressed: () async {
                final user = await signInWithApple();
                navigateAway(user);
              },
            ),
            LoginBtn(
              text: "CONTINUE WITH GOOGLE",
              icon: 'assets/svgs/google_logo.svg',
              onPressed: () async {
                try {
                  final user = await signInWithGoogle();
                  navigateAway(user);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
