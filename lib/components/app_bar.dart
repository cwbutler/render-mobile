import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:render/components/avatar.dart';
import 'package:render/screens/notifications.dart';
import 'package:render/screens/settings.dart';

class RenderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RenderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: SvgPicture.asset('assets/svgs/logo.svg'),
        onPressed: () => {},
      ),
      actions: [
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
        Builder(
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
