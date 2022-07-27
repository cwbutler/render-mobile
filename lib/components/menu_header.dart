import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RenderMenuHeader extends StatelessWidget {
  final String? title;
  const RenderMenuHeader({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        width: double.infinity,
        child: Stack(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: SvgPicture.asset('assets/svgs/close_btn.svg'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 47,
            child: Text(
              title ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Gothic A1',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
