import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
              alignment: const Alignment(0, 0),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Image.asset('assets/images/login_bg.png'),
              )),
          const Positioned.fill(child: LoginBody())
        ],
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> signInWithGoogle() async {
      try {
        final result =
            await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
        debugPrint('Result: ${result.toString()}');
      } on AmplifyException catch (e) {
        debugPrint(e.message);
      }
    }

    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 130),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/logo.png')),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: const Text(
                      "WELCOME TO RENDER",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Mortend',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                if (true) ...[
                  const LoginBtn(
                    text: "CONTINUE WITH APPLE",
                    icon: 'assets/svgs/apple_logo.svg',
                  ),
                  LoginBtn(
                    text: "CONTINUE WITH GOOGLE",
                    icon: 'assets/svgs/google_logo.svg',
                    onPressed: () {
                      signInWithGoogle();
                    },
                  ),
                ]
              ],
            )));
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key, this.text = "", this.icon, this.onPressed})
      : super(key: key);

  final String text;
  final String? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        primary: Colors.white,
        textStyle: const TextStyle(color: Colors.black),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        width: 350,
        height: 52,
        child: ElevatedButton(
          style: style,
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[SvgPicture.asset(icon.toString())],
              Text(text)
            ],
          ),
        ));
  }
}
