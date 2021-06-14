import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_test/features/home/presentation/pages/home_page.dart';
import 'core/routes/route_generator.dart';
import 'features/authentication/presentation/bloc/bloc/authentication_bloc.dart';

import 'features/authentication/presentation/pages/login_page.dart';

import 'locator.dart' as di;
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  GetIt.I.isReady<SharedPreferences>().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final String _token = sl<SharedPreferences>().getString(CACHE_TOKEN);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

Widget _mapStateToWidget(AuthenticationState state) {
  if (state is UserLoggedInState) {
    return HomePage();
  } else if (state is AuthenticationLoadingState) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  } else
    return LoginPage();
}
