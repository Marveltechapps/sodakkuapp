import 'package:sodakkuapp/model/settings/faq_model.dart';

abstract class FaqsState {}

class FaqsInitialState extends FaqsState {}

class FaqsLoadingState extends FaqsState {}

class FaqsSuccessState extends FaqsState {
  final List<FaqsResponse> faqsResponse;

  FaqsSuccessState({required this.faqsResponse});
}

class FaqsErrorState extends FaqsState {
  final String errorMsg;

  FaqsErrorState({required this.errorMsg});
}
