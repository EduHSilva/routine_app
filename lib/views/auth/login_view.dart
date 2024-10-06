import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/config/design_system.dart';
import 'package:routineapp/config/helper.dart';
import 'package:routineapp/views/auth/register_view.dart';
import 'package:routineapp/widgets/custom_button.dart';
import 'package:routineapp/widgets/custom_text_field.dart';
import '../../models/user/login_model.dart';
import '../../viewmodels/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthViewModel _authViewModel = AuthViewModel();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  _login() async {
    if (!_validateForm()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    LoginResponse? response = await _authViewModel.login(
        _usernameController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    if (response?.user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showErrorBar(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: Text(
                        'login'.tr(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryVariant,
                        ),
                      ),
                    ),
                    CustomTextField(
                      labelText: 'email',
                      controller: _usernameController,
                      validator: requiredFieldValidator, 
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      isPassword: true,
                      labelText: 'password',
                      controller: _passwordController,
                      validator: requiredFieldValidator,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        children: [
                          CustomButton(
                            text: 'login',
                            onPressed: _login,
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
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Implementar a lógica para recuperar a senha
                      },
                      child: Text('lostPassword'.tr()),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
