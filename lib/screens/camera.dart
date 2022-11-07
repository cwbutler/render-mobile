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

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Container(color: Colors.black),
              ),
            ),
            MobileScanner(
              controller: cameraController,
              onDetect: (barcode, args) async {
                if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
                  final params = barcode.rawValue!.split('/');
                  final id = params[3];
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: ((context) {
                      return RenderConnectToUser(userId: id);
                    }),
                  );
                }
              },
            ),
          ],
        ));
  }
}
