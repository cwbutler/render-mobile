import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Upcoming Events',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Gothic A1',
              fontWeight: FontWeight.w700,
              fontSize: 16),
        )
      ],
    );
  }
}
