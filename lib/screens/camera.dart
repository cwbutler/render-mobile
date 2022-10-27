import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:render/components/connect_user.dart';

class RenderCamera extends HookConsumerWidget {
  const RenderCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MobileScannerController cameraController = MobileScannerController();

    useEffect(() => () => cameraController.dispose(), []);

    return MobileScanner(
      controller: cameraController,
      onDetect: (barcode, args) async {
        if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
          final params = barcode.rawValue!.split('/').toString();
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            builder: ((context) {
              return RenderConnectToUser(userId: params[2]);
            }),
          );
        }
      },
    );
  }
}
