import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateInput extends HookConsumerWidget {
  final String label;
  final String? initalText;
  final Function? onChange;
  final TextInputType? keyboardType;
  const CreateInput(
      {Key? key,
      this.label = '',
      this.keyboardType = TextInputType.text,
      this.initalText,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initalText);

    useEffect(() {
      if (onChange != null) onChange!(controller.text);
      return null;
    }, [controller.text]);

    return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
            style: const TextStyle(fontFamily: 'Inter', fontSize: 20),
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(labelText: label)));
  }
}
