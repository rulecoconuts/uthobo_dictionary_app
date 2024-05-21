import 'package:dictionary_app/widgets/helper_widgets/rounded_rectangle_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditableTextView extends HookWidget {
  final String? initial;
  final String? label;
  final Future<String?> Function(String value) onEdit;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextStyle? textBoxStyle;
  final TextStyle? textStyle;
  final InputDecoration inputDecoration;
  final TextAlign textAlign;
  final double iconSize;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? plainPlaceholder;
  final bool isPlainExpanded;

  const EditableTextView(
      {this.initial,
      this.label,
      required this.onEdit,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.textBoxStyle,
      this.inputDecoration = const InputDecoration(),
      this.textAlign = TextAlign.start,
      this.textStyle,
      this.iconSize = 25,
      this.minLines,
      this.maxLines,
      this.maxLength,
      this.plainPlaceholder,
      this.isPlainExpanded = true,
      super.key});

  Widget generateEditIcon(BuildContext context) {
    return Icon(
      Icons.edit,
      size: iconSize,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  /// Cancel editing and reset edited text to its previous value
  void cancel(ValueNotifier<String> currentText,
      ValueNotifier<String> textBoxValue, ValueNotifier<bool> isEditing) {
    textBoxValue.value = currentText.value;
    isEditing.value = false;
  }

  /// Save edited text
  void save(
      ValueNotifier<String> currentText,
      ValueNotifier<String> textBoxValue,
      ValueNotifier<bool> isEditing,
      ValueNotifier<String> errorNotif) async {
    String oldValidValue = currentText.value;
    currentText.value = textBoxValue.value;
    isEditing.value = false;
    errorNotif.value = "";
    String? errorMessage = await onEdit(currentText.value);

    if (errorMessage != null) {
      // Edit failed
      // Turn on edit mode, and display error message
      isEditing.value = true;
      // currentText.value = oldValidValue;
      errorNotif.value = errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentText = useState(initial ?? "");
    final textBoxValue = useState(currentText.value);
    final isEditing = useState(false);
    final errorNotif = useState("");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          // LABEL
          Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label!,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                  if (!isEditing.value)
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => isEditing.value = true,
                          child: generateEditIcon(context),
                        ))
                ],
              )),
        if (isEditing.value)
          // TEXTBOX
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: textBoxValue.value,
                textCapitalization: textCapitalization,
                validator: validator,
                onChanged: (value) => textBoxValue.value = value,
                style: textBoxStyle ?? textStyle,
                decoration: inputDecoration,
                textAlign: textAlign,
                minLines: minLines,
                maxLength: maxLength,
                maxLines: maxLines,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: RoundedRectangleTextButton(
                              text: "Cancel",
                              filled: false,
                              onPressed: () => cancel(
                                  currentText, textBoxValue, isEditing))),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          child: RoundedRectangleTextButton(
                              text: "Save",
                              onPressed: () => save(currentText, textBoxValue,
                                  isEditing, errorNotif)))
                    ],
                  ))
            ],
          )
        else
          // PLAIN TEXT
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isPlainExpanded)
                Expanded(
                    child: Text(
                  currentText.value.isEmpty
                      ? plainPlaceholder ?? ""
                      : currentText.value,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.merge(textStyle ?? textBoxStyle)
                      .copyWith(
                          color: currentText.value.isEmpty
                              ? Colors.grey.shade700
                              : null),
                ))
              else
                Text(
                  currentText.value.isEmpty
                      ? plainPlaceholder ?? ""
                      : currentText.value,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.merge(textStyle ?? textBoxStyle)
                      .copyWith(
                          color: currentText.value.isEmpty
                              ? Colors.grey.shade700
                              : null),
                ),
              if (label == null)
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () => isEditing.value = true,
                      child: generateEditIcon(context),
                    ))
            ],
          ),
        if (errorNotif.value.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 15),
            child: Text(
              errorNotif.value,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
