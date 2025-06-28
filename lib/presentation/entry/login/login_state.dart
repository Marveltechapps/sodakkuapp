abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class PhoneNumberCheckState extends LoginState {}

class PhoneNumberSuccessState extends LoginState {
  final bool isEnable;

  PhoneNumberSuccessState({required this.isEnable});
}

class OtpSuccessState extends LoginState {
  final String message;

  OtpSuccessState({required this.message});
}
class OtpErrorState extends LoginState {
  final String errorMessage;

  OtpErrorState({required this.errorMessage});
}
