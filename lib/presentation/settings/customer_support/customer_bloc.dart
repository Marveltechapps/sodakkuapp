import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/settings/faq_model.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_event.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  FaqsBloc() : super(FaqsInitialState()) {
    on<GetFaqsEvent>(getFaqs);
  }

  getFaqs(GetFaqsEvent event, Emitter<FaqsState> emit) async {
    emit(FaqsLoadingState());
    try {
      String url = faqsUrl;
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var faqsResponse = faqsResponseFromJson(response.body);
        emit(FaqsSuccessState(faqsResponse: faqsResponse));
      } else {
        emit(FaqsErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(FaqsErrorState(errorMsg: e.toString()));
    }
  }
}
