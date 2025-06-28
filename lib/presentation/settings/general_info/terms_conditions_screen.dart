import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/settings/terms_and_condition_response_model.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_bloc.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_event.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static List<TermsAndConditionResponse> termsAndConditionResponse = [];
  static WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralInfoBloc(),
      child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
        listener: (context, state) {
          if (state is TermsAndConditionSuccessState) {
            termsAndConditionResponse = state.termsAndConditionResponse;
            controller = WebViewController()
              ..loadHtmlString(termsAndConditionResponse[0].content ?? "");
          }
        },
        builder: (context, state) {
          if (state is GeneralInfoInitialState) {
            //  termsAndConditionResponse = TermsAndConditionResponse();
            context.read<GeneralInfoBloc>().add((GetTermsAndConditionEvent()));
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is GeneralInfoLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: headerColor,
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: headerComponentsColor,
                    size: 16,
                  ),
                ),
                elevation: headerElevation,
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(color: headerComponentsColor),
                ),
              ),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: WebViewWidget(controller: controller),
              ),
            ),
          );
        },
      ),
    );
  }
}
