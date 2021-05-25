import 'package:flutter/material.dart';
import '../../../../core/regex_helper.dart';
import '../bloc/bloc/authentication_bloc.dart';

class CustomLoginRegisterTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final AuthenticationState state;
  final bool isPassword;
  final void Function(String value) onChanged;
  final TextEditingController controller;

  const CustomLoginRegisterTextField({
    @required this.labelText,
    @required this.prefixIcon,
    @required this.isPassword,
    @required this.onChanged,
    @required this.controller,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: !isPassword ? TextInputType.emailAddress : null,
        obscureText: isPassword,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                )
              : null,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.blue[300],
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.blue[300],
            ),
          ),
        ),
        validator: _validatingHelperFun,
      ),
    );
  }

  /// Function to validate email and password
  String _validatingHelperFun(String value) {
    if (isPassword) {
      if (value.length < 6) return 'Password should be at least 6 characters';
      return null;
    } else {
      if (!RegexHelper.emailRegEx.hasMatch(value))
        return 'Please Enter a valid email adress';
      return null;
    }
  }
}
