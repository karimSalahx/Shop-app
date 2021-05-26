import 'package:flutter/material.dart';
import 'package:tdd_test/features/authentication/presentation/pages/login_page.dart';
import 'package:tdd_test/features/authentication/presentation/widgets/animated_obacity_login_register_text.dart';

class CustomAlreadyHaveAnAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 2),
        AnimatedObacityLoginRegisterText(
          text: 'Login',
          onClick: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => LoginPage(),
            ),
          ),
        ),
      ],
    );
  }
}
