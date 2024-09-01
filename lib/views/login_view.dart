import 'package:flutter/material.dart';
import '../models/auth_response.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginViewModel _viewModel = LoginViewModel();
  bool _isLoading = false;

 _login() async {
  setState(() {
    _isLoading = true;
  });
  
  AuthResponse? response = await _viewModel.login(
    _usernameController.text,
    _passwordController.text
  );


  setState(() {
    _isLoading = false;
  });
  
  if (!mounted) return;
  if (response != null) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login failed: Invalid username or password')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login, 
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
