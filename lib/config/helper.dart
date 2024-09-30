import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void showSnackBar(BuildContext context, String message, {bool isError = false}) {
  final snackBar = SnackBar(
    content: Text(message.tr()),
    backgroundColor: isError ? Colors.red : Colors.green, // Diferente cor para erro ou sucesso
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}




String? requiredFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'requiredField'.tr();  // Tradução para 'campo obrigatório'
  }
  return null;
}