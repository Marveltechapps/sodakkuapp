import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/presentation/entry/otp/otp_bloc.dart';
import 'package:sodakkuapp/presentation/entry/otp/otp_event.dart';
import 'package:sodakkuapp/presentation/entry/otp/otp_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  static bool isFilled = false; // Check if OTP is filled
  static String remainingTime = "";
  static int sec = 0;

  static TextEditingController c = TextEditingController();
  static List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  static List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  static List<bool> isEntered = List.generate(4, (index) => false);
  static List<bool> isOtpWrong = List.generate(4, (index) => false);

  formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    remainingTime = "$minutes:$secs";
    sec = int.parse(secs);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) async {
          if (state is OtpEnteredState) {
            isEntered[state.index] = state.isEntered;
            String otp = controllers
                .map((controller) => controller.text)
                .join();
            if (otp.length == 4) {
              context.read<OtpBloc>().add(
                VerifyOtpEvent(mobileNumber: phoneNumber, otp: otp),
              );

              // widget.onOtpComplete(otp); // Call the function when all fields are filled
            }
          } else if (state is TimerRunning) {
            formatDuration(state.duration);
            // debugPrint(remainingTime);
          } else if (state is OtpSuccessState) {
            await TokenService.saveToken(state.verifyOtpResponse.token ?? "");
            context.read<OtpBloc>().add(
              ClearCartDataEvent(mobileNumber: phoneNumber),
            );
            Navigator.pushNamed(context, '/home');
            userId = state.verifyOtpResponse.userId ?? "";

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.verifyOtpResponse.message ?? "")),
            );
            context.read<OtpBloc>().add(
              SaveDataEvent(phoneNo: phoneNumber, userId: userId),
            );
          } else if (state is OtpErrorState) {
            isOtpWrong = List.generate(4, (index) => true);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is OtpResendState) {
            isOtpWrong = List.generate(4, (index) => false);
            isEntered = List.generate(4, (index) => false);
            focusNodes[0].requestFocus();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OtpInitialState) {
            isOtpWrong = List.generate(4, (index) => false);
            controllers = List.generate(4, (index) => TextEditingController());
            isEntered = List.generate(4, (index) => false);
            context.read<OtpBloc>().add(StartTimer());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: headerColor,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: headerComponentsColor,
                ),
              ),
              elevation: headerElevation,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: backgroundimagefound
                    ? BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(bgImage),
                        ),
                      )
                    : BoxDecoration(color: whitecolor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OTP\nVerification',
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(color: primaryTextColor),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'OTP has been sent to +91 $phoneNumber',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: primaryTextColor),
                              ),
                              const SizedBox(height: 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: isOtpWrong[index]
                                          ? Colors.red
                                          : isEntered[index]
                                          ? greenColor
                                          : otpColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      onTap: () {},
                                      controller: controllers[index],
                                      focusNode: focusNodes[index],
                                      cursorColor: appColor,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 1,
                                      decoration: InputDecoration(
                                        counterText:
                                            "", // Hide character counter
                                        border: InputBorder
                                            .none, // Remove default border
                                      ),
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          context.read<OtpBloc>().add(
                                            OtpEnteredEvent(
                                              isEntered: false,
                                              index: index,
                                              otp: value,
                                            ),
                                          );
                                          isOtpWrong = List.generate(
                                            4,
                                            (index) => false,
                                          );
                                        } else {
                                          context.read<OtpBloc>().add(
                                            OtpEnteredEvent(
                                              isEntered: true,
                                              index: index,
                                              otp: value,
                                            ),
                                          );
                                        }

                                        if (value.isNotEmpty && index < 3) {
                                          FocusScope.of(context).requestFocus(
                                            focusNodes[index + 1],
                                          ); // Move to next field
                                        } else if (value.isEmpty && index > 0) {
                                          FocusScope.of(context).requestFocus(
                                            focusNodes[index - 1],
                                          ); // Move to previous field
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 50),
                              Center(
                                child: Text(
                                  remainingTime,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: primaryTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: sec <= 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't get it?",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: primaryTextColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        for (var controller in controllers) {
                                          controller.clear();
                                        }
                                        context.read<OtpBloc>().add(
                                          ResetTimer(),
                                        );
                                        context.read<OtpBloc>().add(
                                          ResendOtpEvent(
                                            mobileNumber: phoneNumber,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Resend',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: appColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
