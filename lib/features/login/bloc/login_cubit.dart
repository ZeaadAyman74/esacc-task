import 'package:esacc_task/core/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context) =>
      BlocProvider.of<LoginCubit>(context);

  Future<void> googleLogin() async {
    try {
      final googleUser = await selectAccount();
      if (googleUser == null) {
        return;
      }
      emit(GoogleSignInLoading());
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(GoogleSignInSuccess());
    } on FirebaseAuthException catch (error) {
      emit(ErrorState(error.code));
    } catch (error) {
      emit(ErrorState(AppStrings.errorMessage));
    }
  }

  Future<GoogleSignInAccount?> selectAccount() async {
    return GoogleSignIn().signIn();
  }

  /// for facebook
  //https://cat-group.firebaseapp.com/__/auth/handler

  Future<void> signInWithFacebook() async {
    try {
      emit(FacebookSignInLoading());
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(FacebookSignInSuccess());
      } else {
        emit(ErrorState('Facebook Login Failed'));
        return;
      }
    } on FirebaseAuthException catch (error) {
      // Handle Firebase authentication exceptions
      emit(ErrorState('Facebook Login Failed'));
    } catch (e) {
      // Handle other exceptions
      emit(ErrorState(AppStrings.errorMessage));
    }
  }
}
