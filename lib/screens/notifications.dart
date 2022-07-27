import 'package:flutter/material.dart';
import 'package:render/components/full_bottomsheet.dart';
import 'package:render/components/menu_header.dart';

class RenderNotifications extends StatelessWidget {
  const RenderNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RenderFullBottomSheetLayout(
      child: Column(children: const <Widget>[
        // Header
        RenderMenuHeader(title: "Notifications"),
      ]),
    );
  }
}
