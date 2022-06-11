abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String? uId;

  LoginSuccessState({required this.uId});
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class GoogleLoginSuccessState extends LoginStates {}

class GoogleLoginErrorState extends LoginStates {}

class FacebookLoginSuccessState extends LoginStates {}

class FacebookLoginErrorState extends LoginStates {}

class CreateUserSuccessState extends LoginStates {}

class CreateUserErrorState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}
