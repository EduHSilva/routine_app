import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:routineapp/models/response.dart';

void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorBar(BuildContext context, DefaultResponse? response) {
  if (response?.message != null && response?.message.trim() != "") {
    showSnackBar(context, response!.message, isError: true);
  } else {
    showSnackBar(context, 'error'.tr(), isError: true);
  }
}

String? requiredFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'requiredField'.tr(); // Tradução para 'campo obrigatório'
  }
  return null;
}
