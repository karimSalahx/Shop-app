import 'package:flutter/material.dart';

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
        Text(
          'Register',
          style: TextStyle(
            color: Colors.blue.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
