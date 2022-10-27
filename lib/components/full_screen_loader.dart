import 'package:flutter/material.dart';

class RenderLoader extends StatelessWidget {
  const RenderLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CircularProgressIndicator(color: Color(0xffff88df)),
      ),
    );
  }
}
