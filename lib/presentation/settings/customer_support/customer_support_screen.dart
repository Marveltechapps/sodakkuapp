import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/settings/faq_model.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_bloc.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_event.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  static List<FaqsResponse> faqsResponse = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqsBloc(),
      child: BlocConsumer<FaqsBloc, FaqsState>(
        listener: (context, state) {
          if (state is FaqsSuccessState) {
            faqsResponse = state.faqsResponse;
          }
        },
        builder: (context, state) {
          if (state is FaqsInitialState) {
            //faqsResponse = FaqsResponse();
            context.read<FaqsBloc>().add((GetFaqsEvent()));
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is FaqsLoadingState,
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
                  "Customer Support",
                  style: TextStyle(color: headerComponentsColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                  itemCount: faqsResponse.length,
                  itemBuilder: (context, i) {
                    return Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          faqsResponse[i].question ?? "",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          faqsResponse[i].answer ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
