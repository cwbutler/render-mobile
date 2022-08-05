import 'package:flutter/material.dart';

class RenderBuyTickets extends StatelessWidget {
  const RenderBuyTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 136, 223, 0.2),
          splashFactory: NoSplash.splashFactory,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        child: Text(
          "buy conference tickets".toUpperCase(),
          style: TextStyle(
            fontFamily: 'Mortend',
            fontSize: 8,
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'buyTickets');
        },
      ),
    );
  }
}
