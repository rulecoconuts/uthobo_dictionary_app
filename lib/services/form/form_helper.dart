import 'package:flutter/material.dart';

class FormHelper {
  static Function(String) generateFormValueEditor(
      String key, ValueNotifier<Map<String, dynamic>> formValues) {
    return (value) => formValues.value[key] = value;
  }
}
