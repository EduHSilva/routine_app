import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined; 

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false, 
  });

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            child: Text(
              text.tr().toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            child: Text(
              text.tr().toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }
}
