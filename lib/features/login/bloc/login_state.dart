part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ErrorState extends LoginState {
  final String error;

  ErrorState(this.error);
}

class GoogleSignInLoading extends LoginState {}

class GoogleSignInSuccess extends LoginState {}

class FacebookSignInLoading extends LoginState {}

class FacebookSignInSuccess extends LoginState {}
