import 'package:flutter/material.dart';

class CreateProgress extends StatelessWidget {
  final int active;
  const CreateProgress({Key? key, this.active = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 54,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressCircle(
                isLarge: (active == 1),
                isActive: active == 1,
              ),
              ProgressCircle(
                isLarge: active == 2,
                isActive: active == 2,
              ),
              ProgressCircle(
                isLarge: active == 3,
                isActive: active == 3,
              ),
              ProgressCircle(
                isLarge: active == 4,
                isActive: active == 4,
              )
            ]));
  }
}

class ProgressCircle extends StatelessWidget {
  final bool isLarge;
  final bool isActive;
  const ProgressCircle({Key? key, this.isLarge = true, this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = (isLarge) ? 12 : 6;
    final Color color =
        (isActive) ? const Color(0xffFF88DF) : const Color(0xffd9d9d9);
    return Container(
      width: width,
      height: width,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
