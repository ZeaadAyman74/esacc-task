import 'package:esacc_task/core/routing/routes.dart';
import 'package:esacc_task/core/utils/app_extensions.dart';
import 'package:esacc_task/core/utils/app_functions.dart';
import 'package:esacc_task/core/utils/colors.dart';
import 'package:esacc_task/core/utils/enums.dart';
import 'package:esacc_task/core/utils/images.dart';
import 'package:esacc_task/core/widgets/button_loading_widget.dart';
import 'package:esacc_task/core/widgets/custom_login_button.dart';
import 'package:esacc_task/features/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit get cubit => LoginCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginCubit, LoginState>(
        listener: _blocListener,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  AppImages.loginImage,
                  height: context.height * .4,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  'Welcome Back',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Login with your social account',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (previous, current) =>
                      current is ErrorState ||
                      current is GoogleSignInLoading ||
                      current is GoogleSignInSuccess,
                  builder: (context, state) {
                    return CustomButton(
                        width: context.width * .7,
                        onPress: () => cubit.googleLogin(),
                        child: state is GoogleSignInLoading
                            ? const ButtonLoadingWidget()
                            : const ButtonTitleWithIcon(
                                title: 'Sign in with google',
                                iconColor: Colors.red,
                                icon: FontAwesomeIcons.google));
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<LoginCubit,LoginState>(
                  buildWhen: (previous, current) =>
                      current is FacebookSignInSuccess ||
                      current is FacebookSignInLoading ||
                      current is ErrorState,
                  builder: (context, state) => CustomButton(
                    width: context.width * .7,
                    color: AppColors.lightSecondaryColor,
                    onPress: () => cubit.signInWithFacebook(),
                    child: const ButtonTitleWithIcon(
                      title: 'Login with facebook',
                      icon: FontAwesomeIcons.facebook,
                      iconColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// /////////////////////////////////////////////////////
  /// //////////////////Helper Methods///////////////////////
  /// /////////////////////////////////////////////////////
  void _blocListener(BuildContext context, LoginState state) {
    if (state is GoogleSignInSuccess || state is FacebookSignInSuccess) {
      context.push(Routes.settings);
    } else if (state is ErrorState) {
      AppFunctions.showToast(message: state.error, state: ToastStates.error);
    }
  }

  /// /////////////////////////////////////////////////////
  /// //////////////////Helper Widgets/////////////////////
  /// /////////////////////////////////////////////////////
}
