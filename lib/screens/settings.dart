import 'package:flutter/material.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';
import 'package:render/models/auth.dart';

class RenderMenu extends StatelessWidget {
  const RenderMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logout() async {
      await RenderUser.logout();
    }

    return RenderFullBottomSheetLayout(
      paddingBottom: 30,
      child: Column(children: <Widget>[
        // Header
        const RenderMenuHeader(title: "Main Menu"),
        // Body
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 65),
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
            ],
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
