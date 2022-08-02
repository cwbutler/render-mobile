import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RenderBuyTickets extends StatelessWidget {
  const RenderBuyTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/tickets.svg'),
            onPressed: () => {},
            tooltip: "",
          ),
        ],
      ),
    );
  }
}
