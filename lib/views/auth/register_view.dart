import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:routineapp/config/design_system.dart';
import 'package:routineapp/config/helper.dart';
import 'package:routineapp/models/user_model.dart';
import 'package:routineapp/views/auth/login_view.dart';
import 'package:routineapp/widgets/custom_button.dart';
import 'package:routineapp/widgets/custom_text_field.dart';
import '../../viewmodels/auth_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}
class RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final AuthViewModel _authViewModel = AuthViewModel();
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'emailRequired'.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'emailInvalid'.tr();
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'passwordRequired'.tr();
    }
    if (value.length < 6) {
      return 'passwordTooShort'.tr();
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'passwordsDoNotMatch'.tr();
    }
    return null;
  }

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  _signUp() async {
    if (!_validateForm()) {
      return; 
    }

    setState(() {
      _isLoading = true;
    });

    UserResponse? response = await _authViewModel.register(
        _nameController.text, _emailController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    if (response?.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('success'.tr()),
          action: SnackBarAction(
              label: 'login'.tr(),
              onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ))
                  }),
        ),
      );
    } else {
      showErrorBar(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: Text(
                          'signUp'.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryVariant,
                          ),
                        ),
                      ),
                      CustomTextField(
                        labelText: 'name',
                        controller: _nameController,
                        validator: requiredFieldValidator,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: 'email',
                        controller: _emailController,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        isPassword: true,
                        labelText: 'password',
                        controller: _passwordController,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        isPassword: true,
                        labelText: 'confirmPassword',
                        controller: _passwordConfirmController,
                        validator: _validateConfirmPassword,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          children: [
                            CustomButton(
                              text: 'signUp',
                              onPressed: _signUp,
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ));
                              },
                              text: 'signIn',
                              isOutlined: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
