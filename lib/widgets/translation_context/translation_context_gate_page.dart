import 'dart:async';

import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/services/constants/constants.dart';
import 'package:dictionary_app/services/language/providers/translation_context_control.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TranslationContextGatePage extends HookConsumerWidget
    with RoutingUtilsAccessor {
  const TranslationContextGatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translationContext = ref.watch(translationContextControlProvider);

    Timer(const Duration(milliseconds: 30), () {
      if (translationContext.hasError) {
        router().replace(Constants.languageSelectionRoutePath);
      } else if (translationContext.hasValue &&
          translationContext.value != null) {
        router().replace(Constants.wordListRoutePath);
      } else if (translationContext.hasValue) {
        router().replace(Constants.languageSelectionRoutePath);
      }
    });

    return Container(
      color: Colors.white,
    );
  }
}
