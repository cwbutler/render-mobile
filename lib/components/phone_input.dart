import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:render/components/input.dart';

class RenderPhoneInput extends HookConsumerWidget {
  final String label;
  final String? initialText;
  final void Function(String)? onChange;

  const RenderPhoneInput({
    Key? key,
    this.label = '',
    this.initialText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController ctrl = TextEditingController(text: initialText);
    return CreateInput(
      label: label,
      controller: ctrl,
      onChange: onChange,
      keyboardType: TextInputType.phone,
    );
  }
}
