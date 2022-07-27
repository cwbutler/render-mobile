import 'package:flutter/material.dart';

class RenderComingSoon extends StatelessWidget {
  const RenderComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 50, bottom: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "COMING SOON!",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Mortend",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 12),
            width: 300,
            child: Image.asset("assets/images/golden_wafflehouse.png"),
          ),
          const Text(
            "This part of the app is still under construction!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff3F3F3F),
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Got It"),
            ),
          ),
        ],
      ),
    );
  }
}
