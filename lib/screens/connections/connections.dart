import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RenderConnectionsScreen extends HookConsumerWidget {
  const RenderConnectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: const Text(
                  "My Connections",
                  style: TextStyle(
                    fontFamily: "Gothic A1",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text(
                "(0)",
                style: TextStyle(
                  fontFamily: "Gothic A1",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff575757),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
