import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/route_generator.dart';
import '../bloc/bloc/authentication_bloc.dart';

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
          else if (state is UserLoggedOutState)
            Navigator.of(context).pushNamed(Routes.loginScreen);
        }, builder: (context, state) {
          if (state is AuthenticationLoadingState)
            return CircularProgressIndicator();
          else
            return TextButton(
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(
                LogoutUserEvent(),
              ),
              child: Text(
                'Log Out',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
        }),
      ),
    );
  }
}
