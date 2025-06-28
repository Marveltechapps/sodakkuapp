import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/entry/otp/otp_event.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;
import 'package:sodakkuapp/model/otp/verify_otp_response_model.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitialState()) {
    on<OtpEnteredEvent>(otpenterfunction);
    on<StartTimer>(onStart);
    on<Tick>(onTick);
    on<ResetTimer>(onReset);
    on<VerifyOtpEvent>(verifyOtp);
    on<ResendOtpEvent>(resendOtp);
    on<SaveDataEvent>(saveData);
    on<ClearCartDataEvent>(clearCart);
  }
  static const int initialDuration = 20 * 1; // 20 minutes in seconds
  late StreamSubscription<int> tickerSubscription;

  clearCart(ClearCartDataEvent event, Emitter<OtpState> emit) async {
    String url = "$clearCartUrl${event.mobileNumber}";
    debugPrint(url);
    try {
      api.Response res = await api.ApiService().postRequest(url, null);

      if (res.statusCode == 200) {
        // var body = jsonDecode(res.resBody);
        // emit(OtpSuccessState(message: "${body["message"]}"));
      } else {
        // emit(OtpErrorState(errorMessage: "Request Failed!"));
      }
    } catch (e) {
      // emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  saveData(SaveDataEvent event, Emitter<OtpState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', event.phoneNo);
    await prefs.setString('userid', event.userId);
    await prefs.setBool('isLoggedIn', true);
    isLoggedInvalue = true;
  }

  void onStart(StartTimer event, Emitter<OtpState> emit) {
    emit(OtpLoadingState());
    emit(TimerRunning(duration: initialDuration));
    startTicker(initialDuration);
  }

  void startTicker(int duration) {
    tickerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (x) => duration - x - 1,
    ).take(duration).listen((remaining) => add(Tick(remaining)));
  }

  void onTick(Tick event, Emitter<OtpState> emit) {
    if (event.duration >= 0) {
      emit(TimerRunning(duration: event.duration));
    } else {
      emit(TimerCompleted(duration: event.duration));
    }
  }

  void onReset(ResetTimer event, Emitter<OtpState> emit) {
    tickerSubscription.cancel();
    startTicker(initialDuration);
    emit(TimerRunning(duration: initialDuration));
  }

  otpenterfunction(OtpEnteredEvent event, Emitter<OtpState> emit) {
    emit(OtpLoadingState());
    emit(
      OtpEnteredState(
        isEntered: event.isEntered,
        index: event.index,
        otp: event.otp,
      ),
    );
  }

  verifyOtp(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
        verifyOtpUrl,
        jsonEncode({
          "mobileNumber": event.mobileNumber,
          "enteredOTP": event.otp,
        }),
      );

      if (res.statusCode == 200) {
        var body = verifyOtpResponseFromJson(res.resBody);
        emit(OtpSuccessState(verifyOtpResponse: body));
      } else {
        var body = jsonDecode(res.resBody);
        emit(OtpErrorState(errorMessage: body["message"]));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  resendOtp(ResendOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    try {
      api.Response res = await api.ApiService().postRequest(
        resendOtpUrl,
        jsonEncode({"mobileNumber": event.mobileNumber}),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.resBody);
        emit(OtpResendState(message: body["message"]));
      } else {
        var body = jsonDecode(res.resBody);
        emit(OtpErrorState(errorMessage: body["message"]));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    tickerSubscription.cancel();
    return super.close();
  }
}
