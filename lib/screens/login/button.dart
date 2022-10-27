import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key, this.text = "", this.icon, this.onPressed})
      : super(key: key);

  final String text;
  final String? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      textStyle: const TextStyle(color: Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );

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
              Text(
                text,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ));
  }
}
