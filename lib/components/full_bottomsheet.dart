import 'package:flutter/material.dart';

class RenderFullBottomSheetLayout extends StatelessWidget {
  final Widget? child;
  final double paddingBottom;
  final double paddingTop;
  const RenderFullBottomSheetLayout({
    Key? key,
    this.child,
    this.paddingBottom = 0,
    this.paddingTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      padding: EdgeInsets.only(
        top: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .padding
                .top +
            paddingTop,
        bottom: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .padding
                .bottom +
            paddingBottom,
      ),
      child: child,
    );
  }
}
