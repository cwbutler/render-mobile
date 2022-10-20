import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:render/models/auth.dart';

class MyQRCode extends HookConsumerWidget {
  const MyQRCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    return Container(
      height: 500,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const Text(
            "MY QR CODE",
            style: TextStyle(
              fontFamily: "Mortend",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: QrImage(data: "render://connect/${user.id}", size: 200),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final cameras = await availableCameras();

            if (cameras.isNotEmpty) {
              final controller = CameraController(
                cameras[1],
                ResolutionPreset.max,
                imageFormatGroup: ImageFormatGroup.bgra8888,
              );
              await controller.initialize();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(14),
            side: const BorderSide(color: Colors.black, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeroIcon(
                HeroIcons.camera,
                size: 26,
                color: Colors.black,
                solid: true,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: const Text(
                  "SCAN",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mortend",
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
