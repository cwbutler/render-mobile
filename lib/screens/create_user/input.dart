import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateInput extends HookConsumerWidget {
  final String label;
  final String? initalText;
  final bool? autocorrect;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;

  const CreateInput({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.initalText,
    this.onChange,
    this.autocorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initalText);

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        onChanged: onChange,
        style: const TextStyle(fontFamily: 'Gothic A1', fontSize: 20),
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: autocorrect ?? false,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
