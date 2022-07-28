import 'package:flutter/material.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';

class RenderNotifications extends StatelessWidget {
  const RenderNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RenderFullBottomSheetLayout(
      child: Column(children: <Widget>[
        // Header
        const RenderMenuHeader(title: "Notifications"),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                bottom:
                    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                        .padding
                        .top),
            child: const Center(
              child: Text("No Notifications"),
            ),
          ),
        )
      ]),
    );
  }
}
