import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_bloc.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_event.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/presentation/widgets/cart/add_address_styles.dart';
import 'package:sodakkuapp/presentation/widgets/success_dialog_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController mailController = TextEditingController();
  static final TextEditingController mobileNoController =
      TextEditingController();

  static final ValueNotifier<bool> isButtonVisible = ValueNotifier(false);
  static bool isUpdate = false;

  static void _updateButtonVisibility() {
    isButtonVisible.value =
        nameController.text.isNotEmpty &&
        mobileNoController.text.isNotEmpty &&
        mailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    nameController.addListener(_updateButtonVisibility);
    mailController.addListener(_updateButtonVisibility);
    mobileNoController.addListener(_updateButtonVisibility);

    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSaveSuccessState) {
            showSuccessDialog(
              true,
              "Your profile has been added",
              "",
              "",
              "save",
              context,
            );
          } else if (state is GetSavedProfileState) {
            nameController.text = state.getSavedProfileModel.name ?? "";
            mobileNoController.text =
                state.getSavedProfileModel.mobileNumber ?? "";
            mailController.text = state.getSavedProfileModel.email ?? "";
            if (mailController.text.isNotEmpty) {
              isUpdate = true;
            }
          } else if (state is UpdateProfileState) {
            context.read<ProfileBloc>().add(
              UpdateProfileApiEvent(
                name: nameController.text,
                mobileNo: mobileNoController.text,
                emailAddress: mailController.text,
              ),
            );
          } else if (state is ProfileErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          if (state is ProfileInitialState) {
            mobileNoController.text = phoneNumber;
            context.read<ProfileBloc>().add(
              GetSavedProfileDataEvent(userId: userId),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
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
                "Profile",
                style: TextStyle(color: headerComponentsColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInputField("Name*", nameController),
                    SizedBox(height: 14),
                    IgnorePointer(
                      ignoring: mobileNoController.text.length == 10,
                      child: _buildInputField(
                        "Mobile Number*",
                        mobileNoController,
                      ),
                    ),
                    SizedBox(height: 14),
                    _buildInputField("Email Address*", mailController),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "We promise not spam you",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: isButtonVisible,
                      builder: (context, bool visible, _) {
                        return visible
                            ? GestureDetector(
                                onTap: () {
                                  isUpdate
                                      ? context.read<ProfileBloc>().add(
                                          UpdateProfileApiEvent(
                                            name: nameController.text,
                                            mobileNo: mobileNoController.text,
                                            emailAddress: mailController.text,
                                          ),
                                        )
                                      : context.read<ProfileBloc>().add(
                                          SaveProfileApiEvent(
                                            name: nameController.text,
                                            mobileNo: mobileNoController.text,
                                            emailAddress: mailController.text,
                                          ),
                                        );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      isUpdate ? "Update" : "Submit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: whitecolor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: whitecolor,
                                    ),
                                  ),
                                ),
                              );
                      },
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

Widget _buildInputField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AddAddressStyles.labelStyle),
      const SizedBox(height: 4),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: greyColor.shade500),
        ),
        height: 50,
        child: TextFormField(
          controller: controller,
          cursorColor: appColor,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: '',
            hintStyle: AddAddressStyles.inputStyle,
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
