import 'package:flutter/material.dart';

class RenderConfirm extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? confirm;
  final String? cancel;
  final Color? confirmColor;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  const RenderConfirm({
    Key? key,
    this.title,
    this.subtitle,
    this.confirm,
    this.cancel,
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 24,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Mortend",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subtitle ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(17),
                primary: confirmColor ?? const Color(0xffEA4335),
              ),
              child: Text(
                confirm ?? "CONFIRM",
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Mortend',
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (onCancel != null) onCancel!();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(17),
                primary: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Text(
                cancel ?? "CANCEL",
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Mortend',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
