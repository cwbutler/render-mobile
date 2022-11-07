import 'package:flutter/material.dart';
import 'package:render/components/connect_button.dart';

class RenderEmptyConnections extends StatelessWidget {
  const RenderEmptyConnections({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: "Gothic A1",
      fontSize: 18,
      color: Color(0xff999999),
    );

    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: 235,
            height: 160,
            child: Image.asset('assets/images/connections_empty.png'),
          ),
          SizedBox(
            width: 210,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    "No connections 😕",
                    style: textStyle,
                  ),
                ),
                const Text(
                  "Use the Connect feature to add new connections",
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          const RenderConnectBtn(),
          const Text(
            "QR code can also be found in the main menu",
            style: TextStyle(
              fontFamily: "Gothic A1",
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
