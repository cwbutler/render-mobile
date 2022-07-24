import 'package:flutter/material.dart';

class CreateHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const CreateHeader({Key? key, this.title = '', this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(title,
              style: const TextStyle(
                  fontFamily: 'Mortend', fontSize: 24, color: Colors.white))),
      Text(subtitle,
          style: const TextStyle(
              fontFamily: 'Gothic A1', fontSize: 16, color: Colors.white))
    ]);
  }
}
