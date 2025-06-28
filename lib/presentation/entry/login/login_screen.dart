import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/entry/login/login_bloc.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static TextEditingController phoneNumberController = TextEditingController();
  static bool isButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is PhoneNumberSuccessState) {
            isButtonEnable = state.isEnable;
            phoneNumber = phoneNumberController.text;
          } else if (state is OtpSuccessState) {
            Navigator.pushNamed(context, '/otp');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            phoneNumberController.clear();
          } else if (state is OtpErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Image.asset(appLogo, height: 250),
                          SizedBox(height: 40),
                          Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enter your 10 digits number',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: primaryTextColor),
                              ),
                              // SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: BoxBorder.all(
                                    color: isButtonEnable
                                        ? secondAppColor
                                        : greyColor,
                                    width: 2,
                                  ),
                                ),
                                width: size.width,
                                height: 48,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageNetwork(
                                      url:
                                          'https://flagcdn.com/w40/in.png', // Indian Flag
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "+91  ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 28,
                                      color: Color(0xFFC6C5C5),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: appColor,
                                        controller: phoneNumberController,
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayMedium,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        onChanged: (value) {
                                          if (value.length == 10) {
                                            context.read<LoginBloc>().add(
                                              PhoneNumberEnteredvent(
                                                isEnable: true,
                                              ),
                                            );
                                          } else {
                                            context.read<LoginBloc>().add(
                                              PhoneNumberEnteredvent(
                                                isEnable: false,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  if (isButtonEnable) {
                                    context.read<LoginBloc>().add(
                                      SendOtpEvent(
                                        mobileNumber:
                                            phoneNumberController.text,
                                      ),
                                    );
                                    //  Navigator.pushNamed(context, '/otp');
                                  } else {}
                                },
                                child: Container(
                                  width: size.width,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isButtonEnable
                                        ? secondAppColor
                                        : greyColor,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: primaryTextColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "By Continuing , You agree to our",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/termsAndConditions',
                                  );
                                },
                                child: Text(
                                  "Terms of Use",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(" & ", textAlign: TextAlign.center),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/privacyPolicy',
                                  );
                                },
                                child: Text(
                                  "Privacy Policy",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
