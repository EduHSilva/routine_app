import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'name'.tr()),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'email'.tr()),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'password'.tr()),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'passwordConfirm'.tr()),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Implementar a lógica de registro
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text('signUp'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('signIn'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
