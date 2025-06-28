import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/entry/login/login_event.dart';
import 'package:sodakkuapp/presentation/entry/login/login_state.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;
import 'package:sodakkuapp/utils/constant.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<PhoneNumberEnteredvent>(phonenumbercheck);
    on<SendOtpEvent>(sendOtp);
  }

  phonenumbercheck(PhoneNumberEnteredvent event, Emitter<LoginState> emit) {
    emit(PhoneNumberCheckState());
    emit(PhoneNumberSuccessState(isEnable: event.isEnable));
  }

  sendOtp(SendOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
        otpUrl,
        jsonEncode({"mobileNumber": event.mobileNumber}),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.resBody);
        emit(OtpSuccessState(message: "${body["message"]}"));
      } else {
        emit(OtpErrorState(errorMessage: "Request Failed!"));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }
}
