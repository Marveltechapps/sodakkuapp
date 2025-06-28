import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_screen.dart';
import 'package:sodakkuapp/presentation/location/location_screen.dart';
import 'package:sodakkuapp/presentation/settings/address/address_bloc.dart';
import 'package:sodakkuapp/presentation/settings/address/address_event.dart';
import 'package:sodakkuapp/presentation/settings/address/address_state.dart';
import 'package:sodakkuapp/presentation/widgets/success_dialog_widget.dart';
import 'package:sodakkuapp/utils/constant.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static GetSavedAddressResponse getSavedAddressResponse =
      GetSavedAddressResponse();

  static String successMsg = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc(),
      child: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressSuccessState) {
            getSavedAddressResponse = state.getSavedAddressResponse;
            debugPrint(getSavedAddressResponse.data![0].label);
          } else if (state is AddressDeletedSuccessState) {
            successMsg = state.deleteAddressResponse.message ?? "";
            showSuccessDialog(
              true,
              "Your address has been Deleted",
              "",
              "",
              "delete",
              context,
            );
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );
            // showSuccessDialog(true, successMsg, "" "", "", "", context);
          } else if (state is AddressErrorState) {
            getSavedAddressResponse.data = [];
          }
        },
        builder: (context, state) {
          if (state is AddressInitialState) {
            getSavedAddressResponse.data = [];
            context.read<AddressBloc>().add(
              (GetSavedAddressEvent(userId: userId)),
            );
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is AddressLoadingState,
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
                  "Address",
                  style: TextStyle(color: headerComponentsColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: getSavedAddressResponse.data!.isEmpty
                      ? Center(
                          child: Text(
                            "No Address Found",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: getSavedAddressResponse.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Column(
                              spacing: 10,
                              children: [
                                Row(
                                  spacing: 15,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      addaddresssvg,
                                      colorFilter: ColorFilter.mode(
                                        appColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getSavedAddressResponse
                                                    .data![i]
                                                    .label ??
                                                "",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium,
                                          ),
                                          Text(
                                            "${getSavedAddressResponse.data![i].details!.houseNo}, ${getSavedAddressResponse.data![i].details!.building}, ${getSavedAddressResponse.data![i].details!.landmark}, ${getSavedAddressResponse.data![i].details!.area}, ${getSavedAddressResponse.data![i].details!.city}, ${getSavedAddressResponse.data![i].details!.state}, ${getSavedAddressResponse.data![i].details!.pincode}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var res = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AddAddress(
                                                id:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .id ??
                                                    "",
                                                label: getSavedAddressResponse
                                                    .data![i]
                                                    .label,
                                                houseNo: getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .houseNo,
                                                building:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .building,
                                                landmark:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .details!
                                                        .landmark,
                                                latitude:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .coordinates!
                                                        .latitude
                                                        .toString(),
                                                longitude:
                                                    getSavedAddressResponse
                                                        .data![i]
                                                        .coordinates!
                                                        .longitude
                                                        .toString(),
                                                isEdit: true,
                                                place: Placemark(
                                                  subLocality:
                                                      getSavedAddressResponse
                                                          .data![i]
                                                          .details!
                                                          .area,
                                                  name: "",
                                                  administrativeArea:
                                                      getSavedAddressResponse
                                                          .data![i]
                                                          .details!
                                                          .state,
                                                  country: "",
                                                  isoCountryCode: "",
                                                  locality:
                                                      getSavedAddressResponse
                                                          .data![i]
                                                          .details!
                                                          .city,
                                                  postalCode:
                                                      getSavedAddressResponse
                                                          .data![i]
                                                          .details!
                                                          .pincode,
                                                  street: "",
                                                  subAdministrativeArea: "",
                                                  subThoroughfare: "",
                                                  thoroughfare: "",
                                                ),
                                                screenType: "editaddress",
                                              );
                                            },
                                          ),
                                        );
                                        if (res == "success") {
                                          if (!context.mounted) return;
                                          context.read<AddressBloc>().add(
                                            (GetSavedAddressEvent(
                                              userId: userId,
                                            )),
                                          );
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        editsvg,
                                        colorFilter: ColorFilter.mode(
                                          appColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<AddressBloc>().add(
                                          DeleteSavedAddressEvent(
                                            area:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .area ??
                                                "",
                                            building:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .building ??
                                                "",
                                            city:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .city ??
                                                "",
                                            houseNo:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .houseNo ??
                                                "",
                                            label:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .label ??
                                                "",
                                            landMark:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .landmark ??
                                                "",
                                            state:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .state ??
                                                "",
                                            pinCode:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .details!
                                                    .pincode ??
                                                "",
                                            latitude: getSavedAddressResponse
                                                .data![i]
                                                .coordinates!
                                                .latitude
                                                .toString(),
                                            longitude: getSavedAddressResponse
                                                .data![i]
                                                .coordinates!
                                                .longitude
                                                .toString(),
                                            id:
                                                getSavedAddressResponse
                                                    .data![i]
                                                    .id ??
                                                "",
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(deletesvg),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  bottom: 30,
                ),
                child: GestureDetector(
                  onTap: () async {
                    /* var res = */
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LocationScreen(screenType: 'address');
                        },
                      ),
                    );
                    //debugPrint(res);
                    if (!context.mounted) return;
                    context.read<AddressBloc>().add(
                      (GetSavedAddressEvent(userId: userId)),
                    );
                  },
                  child: Container(
                    // margin:
                    //     EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                    height: 45,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Add New Address",
                        style: TextStyle(
                          //  fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: whitecolor,
                        ),
                      ),
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
