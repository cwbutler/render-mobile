import 'package:flutter/material.dart';
import 'package:render/components/my_qrcode.dart';

class RenderConnectBtn extends StatelessWidget {
  const RenderConnectBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return const MyQRCode();
            },
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 14),
              child: Image.asset("assets/images/connect.png"),
            ),
            const Text(
              "CONNECT",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Mortend",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
