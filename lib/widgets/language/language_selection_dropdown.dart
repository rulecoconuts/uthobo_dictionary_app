import 'dart:async';

import 'package:dictionary_app/services/language/language_domain_object.dart';
import 'package:dictionary_app/services/language/providers/language_control.dart';
import 'package:dictionary_app/services/pagination/api_page_details.dart';
import 'package:dictionary_app/services/pagination/api_sort.dart';
import 'package:dictionary_app/widgets/language/language_selection_result_panel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageSelectionDropdown extends HookConsumerWidget {
  final Function(LanguageDomainObject language) onSelectionChanged;
  final InputBorder border;
  final LanguageDomainObject? initialLanguage;
  const LanguageSelectionDropdown(
      {required this.onSelectionChanged,
      this.initialLanguage,
      this.border = const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1)),
      Key? key})
      : super(key: key);

  Widget getSearchPanel(
      ValueNotifier<String> searchTermNotifier,
      ValueNotifier<LanguageDomainObject?> selectedLanguage,
      ValueNotifier<TextEditingController> textEditController,
      ValueNotifier<bool> isResultsPanelVisible,
      ValueNotifier<String> groupId,
      ValueNotifier<Timer?> inputWaitTimer,
      WidgetRef ref) {
    return TapRegion(
        groupId: groupId.value,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(12)),
          child: LanguageSelectionResultPanel(
            namePattern: searchTermNotifier.value,
            onSelectionChanged: (language) => changeSelection(language,
                selectedLanguage, textEditController, isResultsPanelVisible),
            onCreated: (newLanguage) {
              // TODO: Select newly creeated language
              changeSelection(newLanguage, selectedLanguage, textEditController,
                  isResultsPanelVisible);
              onSearchTermChanged(newLanguage.name, searchTermNotifier,
                  inputWaitTimer, isResultsPanelVisible, ref);
            },
          ),
        ));
  }

  void changeSelection(
      LanguageDomainObject language,
      ValueNotifier<LanguageDomainObject?> selectedLanguage,
      ValueNotifier<TextEditingController> textEditController,
      ValueNotifier<bool> isResultsPanelVisible) {
    selectedLanguage.value = language;
    textEditController.value.text = language.name;
    isResultsPanelVisible.value = false;
    onSelectionChanged.call(language);
  }

  /// The amount of time that the widget should wait to listen for more input
  /// before applying the search
  Duration getInputWaitDuration() {
    return const Duration(milliseconds: 550);
  }

  void onSearchTermChanged(
      String searchTerm,
      ValueNotifier<String> searchTermNotifier,
      ValueNotifier<Timer?> inputWaitTimer,
      ValueNotifier<bool> isResultsPanelVisible,
      WidgetRef ref) {
    if (isResultsPanelVisible.value) {
      // Clear previous search results

      isResultsPanelVisible.value = false;
    }

    // start timer for search
    inputWaitTimer.value?.cancel();
    inputWaitTimer.value = Timer(getInputWaitDuration(), () {
      // search
      searchTermNotifier.value = searchTerm;
      isResultsPanelVisible.value = true;
    });
  }

  void hidePanelBecauseOfLostFocus(
      ValueNotifier<bool> isResultsPanelVisible,
      ValueNotifier<TextEditingController> textEditingController,
      ValueNotifier<LanguageDomainObject?> selectedLanguage) {
    if (!isResultsPanelVisible.value) return;
    isResultsPanelVisible.value = false;

    if (selectedLanguage.value != null) {
      textEditingController.value.text = selectedLanguage.value!.name;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isResultsPanelVisible = useState(false);
    var inputWaitTimer = useState<Timer?>(null);
    var textEditController = useState(TextEditingController());
    var selectedLanguage = useState<LanguageDomainObject?>(initialLanguage);
    var groupId = useState(
        "${key?.hashCode}_${hashCode}_${DateTime.now().microsecondsSinceEpoch}");

    useEffect(() {
      textEditController.value.text = initialLanguage?.name ?? "";
    }, [initialLanguage]);

    var searchTermNotifier = useState("");
    return PortalTarget(
        visible: isResultsPanelVisible.value,
        anchor: const Aligned(
            follower: Alignment.topCenter,
            target: Alignment.bottomCenter,
            backup: Aligned(
                follower: Alignment.bottomCenter,
                target: Alignment.topCenter,
                offset: Offset(0, 10)),
            offset: Offset(0, 10)),
        portalFollower: isResultsPanelVisible.value
            ? getSearchPanel(
                searchTermNotifier,
                selectedLanguage,
                textEditController,
                isResultsPanelVisible,
                groupId,
                inputWaitTimer,
                ref)
            : null,
        child: TapRegion(
            groupId: groupId.value,
            onTapOutside: (pointerEvent) => hidePanelBecauseOfLostFocus(
                isResultsPanelVisible, textEditController, selectedLanguage),
            child: TextFormField(
              controller: textEditController.value,
              onChanged: (value) => onSearchTermChanged(
                  value,
                  searchTermNotifier,
                  inputWaitTimer,
                  isResultsPanelVisible,
                  ref),
              decoration: InputDecoration(
                  border: border, hintText: "Start typing a language"),
            )));
  }
}
