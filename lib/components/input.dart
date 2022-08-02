import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateInput extends HookConsumerWidget {
  final String label;
  final String? initalText;
  final bool? autocorrect;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;

  const CreateInput({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.initalText,
    this.onChange,
    this.autocorrect,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        style: const TextStyle(fontFamily: 'Gothic A1', fontSize: 20),
        keyboardType: keyboardType,
        autocorrect: autocorrect ?? false,
        decoration: InputDecoration(labelText: label),
        textCapitalization: textCapitalization,
        initialValue: initalText,
      ),
    );
  }
}
