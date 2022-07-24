import 'package:flutter/material.dart';
import 'package:render/create_user/progress.dart';
import 'package:render/create_user/header.dart';

class CreateUserLayout extends StatelessWidget {
  final Widget child;
  final int active;
  final String title;
  final String subtitle;
  const CreateUserLayout(
      {Key? key,
      required this.child,
      this.active = 1,
      this.title = '',
      this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: CreateProgress(active: active),
              centerTitle: true,
            ),
            body: LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight - 80),
                    child: IntrinsicHeight(
                        child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: CreateHeader(title: title, subtitle: subtitle),
                      ),
                      Expanded(child: child)
                    ]))),
              );
            })));
  }
}
