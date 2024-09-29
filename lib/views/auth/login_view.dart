import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/views/auth/register_view.dart';
import 'package:routineapp/widgets/custom_button.dart';
import '../../models/auth_response.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthViewmodel _authViewModel = AuthViewmodel();
  bool _isLoading = false;

  _login() async {
    setState(() {
      _isLoading = true;
    });

    AuthResponse? response = await _authViewModel.login(
        _usernameController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    if (response != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('loginFailed'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'email'.tr()),
                    controller: _usernameController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'password'.tr()),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    text: 'login',
                    onPressed: () {
                      _login();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ));
                    },
                    text: 'signUp',
                    isOutlined: true,
                  ),
                  TextButton(
                    onPressed: () {
                      // Implementar a lógica para recuperar a senha
                    },
                    child: Text('lostPassword'.tr()),
                  ),
                ],
              ),
            ),
    );
  }
}
