import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/regex_helper.dart';
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
  String _email, _password;
  TextEditingController _emailController, _passwordController;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
    return Form(
      key: _globalKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationErrorState)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
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
                  child: Column(
                    children: [
                      LoginPageText(),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Email Address',
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        isPassword: false,
                        controller: _emailController,
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          if (!RegexHelper.emailRegEx.hasMatch(value))
                            return 'Please Enter a valid email adress';
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                          labelText: 'Password',
                          keyBoardType: null,
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          controller: _passwordController,
                          onChanged: (value) => _password = value,
                          validator: (value) {
                            if (value.length < 6)
                              return 'Password should be at least 6 characters';
                            return null;
                          }),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchLogin() {
    _globalKey.currentState.save();
    if (_globalKey.currentState.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        LogInAuthenticationEvent(
          email: _email.trim(),
          password: _password.trim(),
        ),
      );
    }
    _passwordController.clear();
  }
}
