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
    const textStyle = TextStyle(fontSize: 12);
    final highlightTextStyle = TextStyle(
      fontSize: 12,
      color: Theme.of(context).primaryColor,
    );

    navigateAway(RenderUser user) {
      if (user.user == null) return;
      final nextRoute = (user.hasProfile) ? 'home' : 'create';
      Navigator.popAndPushNamed(context, nextRoute);
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
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
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              width: 200,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    "By continuing, you agree to our ",
                    style: textStyle,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'terms'),
                    child: Text("Terms ", style: highlightTextStyle),
                  ),
                  const Text("and our ", style: textStyle),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'privacy'),
                    child: Text("Privacy Policy.", style: highlightTextStyle),
                  ),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
