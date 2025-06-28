import 'package:sodakkuapp/model/otp/verify_otp_response_model.dart';

abstract class OtpState {}

class OtpLoadingState extends OtpState {}

class OtpInitialState extends OtpState {}

class TimerInitial extends OtpState {
  final int duration;

  TimerInitial({required this.duration});
}

class TimerRunning extends OtpState {
  final int duration;

  TimerRunning({required this.duration});
}

class TimerCompleted extends OtpState {
  final int duration;

  TimerCompleted({required this.duration});
}

class OtpEnteredState extends OtpState {
  final bool isEntered;
  final int index;
  final String otp;

  OtpEnteredState({
    required this.isEntered,
    required this.index,
    required this.otp,
  });
}

class OtpResendState extends OtpState {
  final String message;

  OtpResendState({required this.message});
}

class OtpSuccessState extends OtpState {
  final VerifyOtpResponse verifyOtpResponse;

  OtpSuccessState({required this.verifyOtpResponse});
}

class OtpErrorState extends OtpState {
  final String errorMessage;

  OtpErrorState({required this.errorMessage});
}
