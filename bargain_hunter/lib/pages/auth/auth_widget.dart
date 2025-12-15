import 'package:flutter/material.dart';

class AuthTextFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
      ],
    );
  }
}

class AuthToggleButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onToggle;

  const AuthToggleButton({
    super.key,
    required this.isLogin,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onToggle,
      child: Text(
        isLogin
            ? "Don't have an account? Sign up"
            : "Already have an account? Log in",
            style: TextStyle(
              fontFamily: 'InriaSerif',
              fontStyle: FontStyle.italic
            ),
      ),
    );
  }
}
