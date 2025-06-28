import 'package:sodakkuapp/model/settings/privacy_policy_response_model.dart';
import 'package:sodakkuapp/model/settings/terms_and_condition_response_model.dart';

abstract class GeneralInfoState {}

class GeneralInfoInitialState extends GeneralInfoState {}

class GeneralInfoLoadingState extends GeneralInfoState {}

class TermsAndConditionSuccessState extends GeneralInfoState {
  final List<TermsAndConditionResponse> termsAndConditionResponse;

  TermsAndConditionSuccessState({required this.termsAndConditionResponse});
}

class PrivacyPolicySuccessState extends GeneralInfoState {
  final PrivacyPolicyResponse privacyPolicyResponse;

  PrivacyPolicySuccessState({required this.privacyPolicyResponse});
}

class GeneralInfoErrorState extends GeneralInfoState {
  final String errorMsg;

  GeneralInfoErrorState({required this.errorMsg});
}
