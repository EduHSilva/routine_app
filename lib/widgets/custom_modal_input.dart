import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/widgets/custom_button.dart';
import 'package:routineapp/widgets/custom_text_field.dart';

class CustomModalInput extends StatelessWidget {
  final String title;
  final List<String>? hintTexts;
  final Function(Map<String, String>) onConfirm;
  final bool isForm;
  final bool isWarn;

  final Map<String, String>? initialValues;

  const CustomModalInput({
    super.key,
    required this.title,
    required this.onConfirm,
    this.hintTexts,
    this.isForm = false,
    this.initialValues,
    this.isWarn = false,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = <TextEditingController>[];

    if (isForm && hintTexts != null) {
      for (var i = 0; i < hintTexts!.length; i++) {
        final controller = TextEditingController();
        if (initialValues != null && initialValues!.containsKey(hintTexts![i])) {
          controller.text = initialValues![hintTexts![i]]!;
        }
        controllers.add(controller);
      }
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        title.tr(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isForm && hintTexts != null)
              for (var i = 0; i < hintTexts!.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomTextField(
                    labelText: hintTexts![i],
                    controller: controllers[i],
                  ),
                ),
            if (!isForm) // Caso seja um modal simples
              Text(hintTexts!.first.tr()),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'cancel',
          isOutlined: true,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(130, 45),
          ),
        ),
        CustomButton(
          onPressed: () {
            final values = <String, String>{};

            for (var i = 0; i < controllers.length; i++) {
              if (controllers[i].text.isNotEmpty) {
                values[hintTexts != null ? hintTexts![i] : ""] = controllers[i].text;
              }
            }

            if (values.isNotEmpty || isWarn) {
              onConfirm(values);
              Navigator.of(context).pop();
            }
          },
          text: 'confirm',
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(130, 45),
            backgroundColor: isWarn ? Colors.red : null
          ),
        ),
      ],
    );
  }
}
