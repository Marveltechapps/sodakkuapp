abstract class LoginEvent {}

class PhoneNumberEnteredvent extends LoginEvent {
  final bool isEnable;

  PhoneNumberEnteredvent({required this.isEnable});
}


class SendOtpEvent extends LoginEvent {
  final String mobileNumber;

  SendOtpEvent({required this.mobileNumber});
}
