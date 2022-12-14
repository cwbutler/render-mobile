import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';
import 'package:render/components/my_qrcode.dart';
import 'package:render/models/auth.dart';
import 'package:render/components/confirm_delete.dart';

class RenderMenu extends HookConsumerWidget {
  const RenderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutUser = ref.read(userProvider.notifier).logout;

    goToLogin() {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
    }

    logout() async {
      showModalBottomSheet(
        isDismissible: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        builder: (BuildContext context) {
          return RenderConfirm(
            title: "Log Out your account?",
            subtitle: "Are you sure want to log out of your Render account?",
            confirm: "LOG OUT",
            confirmColor: const Color(0xffFBBC05),
            onConfirm: () async {
              await logoutUser();
              goToLogin();
            },
          );
        },
      );
    }

    return RenderFullBottomSheetLayout(
      paddingBottom: 30,
      child: Column(children: <Widget>[
        // Header
        const RenderMenuHeader(title: "Main Menu"),
        // Body
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RenderMenuSettingsLink(
                    label: "VIEW PROFILE",
                    onPressed: () => Navigator.pushNamed(context, 'profile'),
                  ),
                  RenderMenuSettingsLink(
                    label: "SETTINGS",
                    onPressed: () => Navigator.pushNamed(context, 'settings'),
                  ),
                  RenderMenuSettingsLink(
                    label: "PODCAST",
                    onPressed: () => Navigator.pushNamed(context, 'podcast'),
                  ),
                  RenderMenuSettingsLink(
                    label: "DISCORD",
                    onPressed: () => Navigator.pushNamed(context, 'discord'),
                  ),
                  RenderMenuSettingsLink(
                    label: "MERCH SHOP",
                    onPressed: () => Navigator.pushNamed(context, 'merch'),
                  ),
                  RenderMenuSettingsLink(
                    label: "BUY TICKETS",
                    color: const Color(0xffff88df),
                    onPressed: () => Navigator.pushNamed(context, 'buyTickets'),
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return const MyQRCode();
                },
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: Image.asset("assets/images/connect.png"),
                ),
                const Text(
                  "CONNECT",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mortend",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Logout
        TextButton(
          onPressed: logout,
          child: const Text(
            "LOG OUT",
            style: TextStyle(
              color: Colors.amber,
              fontFamily: 'Mortend',
              fontSize: 20,
            ),
          ),
        )
      ]),
    );
  }
}

class RenderMenuSettingsLink extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final String? label;

  const RenderMenuSettingsLink({
    Key? key,
    this.onPressed,
    this.color,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextButton(
        onPressed: onPressed ?? () {},
        child: Text(
          label ?? "",
          style: TextStyle(
            fontFamily: "Mortend",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: (color == null) ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
