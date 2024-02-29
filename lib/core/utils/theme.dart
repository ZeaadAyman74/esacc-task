import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
        // primarySwatch: AppColors.getLightMaterialColor(),
        // fontFamily: AppFonts.mulish,
        colorScheme: const ColorScheme.light(primary: Colors.white),
        useMaterial3: true,
        primaryColor: AppColors.lightPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.lightPrimaryColor),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 16.sp,
              color: AppColors.lightPrimaryColor,
              fontWeight: FontWeight.w700),
          iconTheme: const IconThemeData(color: AppColors.lightPrimaryColor),
        ),
        tabBarTheme: const TabBarTheme(indicatorColor: AppColors.tabBarIndicator),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 20.sp,
              color: AppColors.titleLarge,
              fontWeight: FontWeight.w700),

          titleMedium: TextStyle(
              fontSize: 18.sp,
              color: AppColors.titleMedium,
              fontWeight: FontWeight.w400),

          /// for text button
          titleSmall: TextStyle(
            fontSize: 10.sp,
            color: AppColors.titleSmall,
            fontWeight: FontWeight.w700,
          ),

          /// for hint
          bodySmall: TextStyle(
            fontSize: 12.sp,
            color: AppColors.bodySmall,
            fontWeight: FontWeight.w600,
          ),

          bodyMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyMedium,
          ),

          labelSmall: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.labelSmall,
          ),

          labelMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelMedium,
          ),
          headlineLarge: TextStyle(
            fontSize: 60.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.lightPrimaryColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.lightPrimaryColor,
        ),
        focusColor: AppColors.lightPrimaryColor,
        disabledColor: AppColors.lightSecondaryColor,
        indicatorColor: AppColors.lightPrimaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              const MaterialStatePropertyAll(AppColors.lightPrimaryColor),
          padding: const MaterialStatePropertyAll(
              EdgeInsetsDirectional.symmetric(vertical: 10)),
          elevation: const MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r))),
          enableFeedback: true,
          textStyle: MaterialStatePropertyAll(TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,)),
          // textStyle: ,
        )),
        cardColor: AppColors.lightCardColor,
        primaryColorLight: AppColors.tabBarIndicator,
        primaryColorDark: Colors.black,
      );

}
