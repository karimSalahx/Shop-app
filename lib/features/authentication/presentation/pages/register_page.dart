import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_test/core/regex_helper.dart';
import 'package:tdd_test/features/authentication/presentation/widgets/custom_already_have_an_account.dart';
import '../../domain/usecases/register_user.dart';
import '../bloc/bloc/authentication_bloc.dart';
import '../widgets/custom_headline_text.dart';
import '../widgets/custom_login_register_button.dart';
import '../widgets/custom_login_register_textfield.dart';
import 'logged_in_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name, _phone, _email, _password;
  TextEditingController _nameController,
      _phoneController,
      _passwordController,
      _emailController;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (BuildContext context, AuthenticationState state) {
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
              else if (state is AuthenticationRegisteredState)
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => LoggedInPage(),
                  ),
                );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomHeadLineText('REGISTER'),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Name',
                        prefixIcon: Icons.person_outline,
                        isPassword: false,
                        onChanged: (String value) => _name = value,
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) return 'Please Enter your name';
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Phone',
                        prefixIcon: Icons.phone_outlined,
                        isPassword: false,
                        onChanged: (String value) => _phone = value,
                        controller: _phoneController,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please Enter your Phone Number';
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        isPassword: false,
                        onChanged: (String value) => _email = value,
                        controller: _emailController,
                        validator: (value) {
                          if (!RegexHelper.emailRegEx.hasMatch(value))
                            return 'Please Enter a valid email adress';
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomLoginRegisterTextField(
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        onChanged: (String value) => _password = value,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.length < 6)
                            return 'Password should be at least 6 characters';
                          return null;
                        },
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
                              isLogin: false,
                              onPressed: () => _dispatchRegister(),
                            );
                        },
                      ),
                      SizedBox(height: 20),
                      CustomAlreadyHaveAnAccount()
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

  void _dispatchRegister() {
    _globalKey.currentState.save();
    if (_globalKey.currentState.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        RegisterAuthenticationEvent(
          RegisterParamModel(
            email: _email.trim(),
            password: _password.trim(),
            name: _name.trim(),
            phone: _phone.trim(),
          ),
        ),
      );
    }
  }
}
