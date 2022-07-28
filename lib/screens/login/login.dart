import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:render/screens/login/body.dart';

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
