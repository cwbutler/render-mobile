import 'package:flutter/material.dart';

class RenderProfileField extends StatelessWidget {
  final String? label;
  final String? value;
  final bool? isActive;

  const RenderProfileField({
    Key? key,
    this.label,
    this.value,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            label ?? "",
            style: const TextStyle(
              color: Color(0xff8B8B8B),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 240,
            child: Text(
              value ?? "",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: (isActive ?? false)
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
