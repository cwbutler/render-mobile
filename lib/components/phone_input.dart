import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    this.initialText = '',
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final utils = PhoneNumberUtil();
    final ctrl = useTextEditingController(text: initialText);
    final update = useValueListenable(ctrl);

    void updateValue(String text) async {
      final value = await utils.format(text, "US");
      ctrl
        ..text = value
        ..selection = TextSelection.collapsed(offset: value.length);
      if (onChange != null) {
        onChange!(value);
      }
    }

    useEffect(() {
      updateValue(update.text);
      return;
    }, [update.text]);

    useEffect(() {
      if (initialText != null) updateValue(initialText!);
      return;
    }, []);

    return CreateInput(
      label: label,
      controller: ctrl,
      keyboardType: TextInputType.phone,
    );
  }
}
