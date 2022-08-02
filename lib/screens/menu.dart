import 'package:flutter/material.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';
import 'package:render/models/auth.dart';
import 'package:render/components/confirm_delete.dart';

class RenderMenu extends StatelessWidget {
  const RenderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              await RenderUser.logout();
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
            child: Container(
              margin: const EdgeInsets.only(bottom: kToolbarHeight),
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
                    const RenderMenuSettingsLink(
                      label: "PODCAST",
                    ),
                    const RenderMenuSettingsLink(
                      label: "DISCORD",
                    ),
                    const RenderMenuSettingsLink(
                      label: "MERCH SHOP",
                    ),
                    const RenderMenuSettingsLink(
                      label: "BUY TICKETS",
                    ),
                  ],
                ),
              ),
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
  final String? label;

  const RenderMenuSettingsLink({
    Key? key,
    this.onPressed,
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
          style: const TextStyle(
            fontFamily: "Mortend",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
