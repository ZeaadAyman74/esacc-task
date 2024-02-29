import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:esacc_task/core/network/connection.dart';
import 'package:esacc_task/core/network/error_model.dart';
import 'package:esacc_task/core/routing/router.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // Connectivity
    sl.registerLazySingleton<InternetStatus>(() => InternetStatus(sl()));
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
    sl.registerLazySingleton<AppRouter>(() => AppRouter(),);

    //Error Handling
    // sl.registerLazySingleton<ErrorModel>(() => const ErrorModel());
  }
}
