import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/regex_helper.dart';
import '../bloc/bloc/authentication_bloc.dart';

class CustomLoginRegisterTextField extends StatelessWidget {
  final String labelText;

  final IconData prefixIcon;
  final AuthenticationState state;
  final bool isPassword;
  final void Function(String value) onChanged;
  final void Function(String value) validator;
  final TextEditingController controller;

  const CustomLoginRegisterTextField({
    @required this.labelText,
    @required this.prefixIcon,
    @required this.isPassword,
    @required this.onChanged,
    @required this.controller,
    @required this.validator,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: controller,
              onSaved: onChanged,
              keyboardType: !isPassword ? TextInputType.emailAddress : null,
              obscureText: isPassword && !(state is PasswordVisibleState),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
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
              validator: validator,
            ),
            if (isPassword)
              Positioned(
                right: 12,
                child: GestureDetector(
                  onTap: () => BlocProvider.of<AuthenticationBloc>(context).add(
                    ChangePasswordVisibiliyEvent(),
                  ),
                  child: Icon(
                    _showIconBasedOnState(state),
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Function to validate email and password

  IconData _showIconBasedOnState(AuthenticationState state) {
    if (state is PasswordVisibleState) return Icons.visibility_off_outlined;
    return Icons.visibility_outlined;
  }
}
