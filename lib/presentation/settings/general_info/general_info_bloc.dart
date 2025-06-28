import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/settings/privacy_policy_response_model.dart';
import 'package:sodakkuapp/model/settings/terms_and_condition_response_model.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_event.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class GeneralInfoBloc extends Bloc<GeneralInfoEvent, GeneralInfoState> {
  GeneralInfoBloc() : super(GeneralInfoInitialState()) {
    on<GetTermsAndConditionEvent>(getTermsAndCondition);
    on<GetPrivacyPolicyEvent>(getPrivacyPolicy);
  }

  getTermsAndCondition(
    GetTermsAndConditionEvent event,
    Emitter<GeneralInfoState> emit,
  ) async {
    emit(GeneralInfoLoadingState());
    try {
      String url = termsAndConditionUrl;
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var gerTermsAndConditionResponse = termsAndConditionResponseFromJson(
          response.body,
        );
        emit(
          TermsAndConditionSuccessState(
            termsAndConditionResponse: gerTermsAndConditionResponse,
          ),
        );
      } else {
        emit(GeneralInfoErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(GeneralInfoErrorState(errorMsg: e.toString()));
    }
  }

  getPrivacyPolicy(
    GetPrivacyPolicyEvent event,
    Emitter<GeneralInfoState> emit,
  ) async {
    emit(GeneralInfoLoadingState());
    try {
      String url = privacyPolicyUrl;
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var privacyPolicyResponse = privacyPolicyResponseFromJson(
          response.body,
        );
        emit(
          PrivacyPolicySuccessState(
            privacyPolicyResponse: privacyPolicyResponse,
          ),
        );
      } else {
        emit(GeneralInfoErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(GeneralInfoErrorState(errorMsg: e.toString()));
    }
  }
}
