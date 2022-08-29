import 'package:flutter/material.dart';
import 'package:render/screens/login/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned.fill(child: LoginBody())
        ],
      ),
    );
  }
}
