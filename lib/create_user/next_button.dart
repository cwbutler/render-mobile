import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  const NextButton({Key? key, this.onPressed, this.title = 'Next'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(22),
        side: const BorderSide(width: 500),
        primary: Colors.white,
        textStyle: const TextStyle(fontFamily: 'Mortend', fontSize: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));

    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: style,
            onPressed: onPressed,
            child: Text(title!, style: const TextStyle(color: Colors.black))));
  }
}
