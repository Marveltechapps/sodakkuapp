import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/settings/terms_and_condition_response_model.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_bloc.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_event.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_info_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static List<TermsAndConditionResponse> termsAndConditionResponse = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralInfoBloc(),
      child: BlocConsumer<GeneralInfoBloc, GeneralInfoState>(
        listener: (context, state) {
          if (state is TermsAndConditionSuccessState) {
            termsAndConditionResponse = state.termsAndConditionResponse;

            if (termsAndConditionResponse.isNotEmpty &&
                termsAndConditionResponse[0].content != null) {
              // Sanitize content: remove \n and <script> tags
              String sanitized = termsAndConditionResponse[0].content!
                  .replaceAll(r'\n', '')
                  .replaceAll(
                    RegExp(
                      r'<script[^>]*>[\s\S]*?<\/script>',
                      caseSensitive: false,
                    ),
                    '',
                  );

              termsAndConditionResponse[0].content = sanitized;
            }
          }
        },
        builder: (context, state) {
          if (state is GeneralInfoInitialState) {
            context.read<GeneralInfoBloc>().add(GetTermsAndConditionEvent());
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
                  onPressed: () => Navigator.pop(context),
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
              body: termsAndConditionResponse.isEmpty
                  ? SizedBox()
                  : SingleChildScrollView(
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1280),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 0,
                                  maxHeight: constraints.maxHeight,
                                ),
                                child: kIsWeb
                                    ? Html(
                                        data: termsAndConditionResponse[0]
                                            .content!,
                                        style: {
                                          'body': Style(
                                            padding: HtmlPaddings.zero,
                                            margin: Margins.zero,
                                            color: Colors.black,
                                          ),
                                          'h1': Style(color: Colors.black),
                                          'h2': Style(color: Colors.black),
                                          'h3': Style(color: Colors.black),
                                          'h4': Style(color: Colors.black),
                                          'h5': Style(color: Colors.black),
                                          'h6': Style(color: Colors.black),
                                          'p': Style(
                                            fontSize: FontSize.medium,
                                            color: Colors.black,
                                          ),
                                          'span': Style(color: Colors.black),
                                          'ul': Style(color: Colors.black),
                                          'li': Style(color: Colors.black),
                                        },
                                      )
                                    : Html(
                                        data:
                                            termsAndConditionResponse[0]
                                                .content ??
                                            "",
                                        style: {
                                          "*": Style(
                                            color: Colors
                                                .black, // Set all text color to black
                                          ),
                                        },
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
