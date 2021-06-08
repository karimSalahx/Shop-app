import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/data/datasources/home_get_home_products.dart';
import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/home/domain/usecases/get_home_products.dart';
import 'features/home/presentation/bloc/bloc/home_bloc.dart';
import 'features/authentication/data/datasources/authentication_logout_user.dart';
import 'features/authentication/domain/usecases/logout_user.dart';
import 'features/authentication/data/datasources/authentication_login_user.dart';
import 'features/authentication/data/repository/authentication_repository_impl.dart';
import 'features/authentication/domain/repository/authentication_repository.dart';
import 'features/authentication/domain/usecases/login_user.dart';
import 'features/authentication/domain/usecases/register_user.dart';
import 'features/authentication/presentation/bloc/bloc/authentication_bloc.dart';

import 'features/authentication/data/datasources/authentication_register_user.dart';

final sl = GetIt.I;

Future<void> init() async {
  await _setupAuth();
  await _setupHome();
}

Future<void> _setupAuth() async {
  sl.registerFactory(
    () => AuthenticationBloc(
      loginUser: sl(),
      registerUser: sl(),
      logoutUser: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationLoginUser: sl(),
      authenticationRegisterUser: sl(),
      authenticationLogoutUser: sl(),
    ),
  );
  sl.registerLazySingleton<AuthenticationLoginUser>(
    () => AuthenticationLoginUserImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<AuthenticationRegisterUser>(
      () => AuthenticationRegisterUserImpl(sl()));

  sl.registerLazySingleton<AuthenticationLogoutUser>(
    () => AuthenticationLogoutUserImpl(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  sl.registerLazySingleton(() => http.Client());
}

Future<void> _setupHome() async {
  sl.registerFactory(() => HomeBloc(getHomeProducts: sl()));
  sl.registerLazySingleton(() => GetHomeProducts(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeGetHomeProducts>(
      () => HomeGetHomeProductsImpl(sl()));
}
