import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/settings/terms_and_condition_response_model.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_bloc.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_event.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_state.dart';
import 'package:sodakkuapp/presentation/settings/general_info/utils/mobile_html_viewer.dart';
import 'package:sodakkuapp/utils/constant.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static List<TermsAndConditionResponse> termsAndConditionResponse = [];

  @override
  Widget build(BuildContext context) {
    final staticAnchorKey = GlobalKey();
    return BlocProvider(
      create: (context) => GeneralInfoBloc(),
      child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
        listener: (context, state) {
          if (state is TermsAndConditionSuccessState) {
            termsAndConditionResponse = state.termsAndConditionResponse;
            termsAndConditionResponse[0].content = termsAndConditionResponse[0]
                .content!
                .replaceAll(r'\n', '');
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
              body: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 1280),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: kIsWeb
                          ? (termsAndConditionResponse.isNotEmpty
                                ? Html(
                                    shrinkWrap: true,
                                    key: staticAnchorKey,
                                    data:
                                        termsAndConditionResponse[0].content ??
                                        "<html><head></head><body><p>Terms & Conditions Not loaded Properly</p></html>",
                                    style: {
                                      'p': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h1': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h2': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h3': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h4': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h5': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'h6': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'span': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'ul': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                      'li': Style(
                                        // maxLines: 2,
                                        textOverflow: TextOverflow.clip,
                                        color: Colors.black,
                                      ),
                                    },
                                  )
                                : Text('loading...'))
                          : MobileHtmlView(
                              assetPath:
                                  termsAndConditionResponse[0].content ??
                                  "<html><head></head><body><p>Terms & Conditions Not loaded Properly</p></html>",
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
