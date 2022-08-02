import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/buy_tickets.dart';
import 'package:render/screens/notifications.dart';
import 'package:render/screens/menu.dart';

class RenderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RenderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const RenderAvatar(),
          onPressed: () => {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return const RenderMenu();
              },
            )
          },
        ),
      ),
      actions: [
        const RenderBuyTickets(),
        IconButton(
          icon: SvgPicture.asset('assets/svgs/notifications.svg'),
          onPressed: () => {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return const RenderNotifications();
              },
            )
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
