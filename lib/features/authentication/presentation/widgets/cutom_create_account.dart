import 'package:flutter/material.dart';
import 'package:tdd_test/features/authentication/presentation/pages/register_page.dart';
import 'package:tdd_test/features/authentication/presentation/widgets/animated_obacity_login_register_text.dart';

class CustomCreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 2),
        AnimatedObacityLoginRegisterText(
          text: 'Register',
          onClick: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => RegisterPage(),
            ),
          ),
        ),
      ],
    );
  }
}