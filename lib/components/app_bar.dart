import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RenderAppBar extends StatelessWidget {
  const RenderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset('assets/svgs/logo.svg'),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/svgs/notifications.svg'),
          onPressed: () => {},
        ),
        IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            child: const Text('AH'),
          ),
          onPressed: () => {},
        )
      ],
    );
  }
}
