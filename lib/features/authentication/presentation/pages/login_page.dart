import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/authentication_bloc.dart';
import 'logged_in_page.dart';
import '../widgets/custom_login_register_button.dart';
import '../widgets/cutom_create_account.dart';
import '../widgets/custom_login_register_textfield.dart';
import '../widgets/login_page_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationErrorState)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Theme.of(context).errorColor,
                      ),
                    );
                  else if (state is AuthenticationLoggedInState)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => LoggedInPage(),
                      ),
                    );
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      LoginPageText(),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        isPassword: false,
                        controller: _emailController,
                        onChanged: (value) => _email = value,
                      ),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        controller: _passwordController,
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is AuthenticationLoadingState)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          else
                            return CustomLoginRegisterButton(
                              isLogin: true,
                              onPressed: () => _dispatchLogin(),
                            );
                        },
                      ),
                      SizedBox(height: 20),
                      CustomCreateAccount(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchLogin() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      LogInAuthenticationEvent(
        email: _email.trim(),
        password: _password.trim(),
      ),
    );
  }
}
