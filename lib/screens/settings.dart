import 'package:flutter/material.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';
import 'package:render/models/auth.dart';

class RenderMenu extends StatelessWidget {
  const RenderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToLogin() {
      Navigator.pushReplacementNamed(context, 'login');
    }

    logout() async {
      await RenderUser.logout();
      goToLogin();
    }

    return RenderFullBottomSheetLayout(
      paddingBottom: 30,
      child: Column(children: <Widget>[
        // Header
        const RenderMenuHeader(title: "Main Menu"),
        // Body
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffFF88DF),
                      child: RenderAvatar(
                        width: 95,
                        height: 95,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
                const RenderMenuSettingsLink(
                  label: "VIEW PROFILE",
                ),
                const RenderMenuSettingsLink(
                  label: "SETTINGS",
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
        // Logout
        TextButton(
          onPressed: logout,
          child: const Text(
            "LOGOUT",
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
