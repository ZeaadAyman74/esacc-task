import 'package:esacc_task/core/injection/di_container.dart';
import 'package:esacc_task/core/routing/router.dart';
import 'package:esacc_task/core/routing/routes.dart';
import 'package:esacc_task/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            onGenerateRoute: sl<AppRouter>().generateRoute,
            initialRoute: Routes.login,
            navigatorKey: sl<AppRouter>().navigatorKey,
          )
    );
  }
}