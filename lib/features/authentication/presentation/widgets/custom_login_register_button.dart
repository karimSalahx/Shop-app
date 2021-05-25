import 'package:flutter/material.dart';

class CustomLoginRegisterButton extends StatelessWidget {
  final bool isLogin;
  final void Function() onPressed;
  CustomLoginRegisterButton({@required this.isLogin, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .07,
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            isLogin ? 'LOGIN' : 'REGISTER',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.blue.shade300,
          ),
        ),
      ),
    );
  }
}
