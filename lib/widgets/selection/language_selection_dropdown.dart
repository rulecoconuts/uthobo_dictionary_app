import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelectionDropdown extends HookConsumerWidget {
  final Function(LanguageDomainObject language) onSelectionChanged;
  const LanguageSelectionDropdown({required this.onSelectionChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          hintText: "Type a language"),
    );
  }
}
