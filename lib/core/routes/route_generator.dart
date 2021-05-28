import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../features/authentication/presentation/pages/logged_in_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => LoggedInPage());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginPage());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
            centerTitle: true,
          ),
          body: Center(
            child: Text(
              'Page Not Found',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class Routes {
  static const registerScreen = '/register';
  static const loginScreen = '/login';
  static const homeScreen = '/homeScreen';
}
