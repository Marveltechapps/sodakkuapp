import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_bloc.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_event.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_state.dart';
import 'package:sodakkuapp/presentation/location/yourlocation/your_location_screen.dart';
import 'package:sodakkuapp/presentation/widgets/success_dialog_widget.dart';
import 'package:sodakkuapp/utils/constant.dart';
import '../../widgets/cart/add_address_styles.dart';

class AddAddress extends StatefulWidget {
  final Placemark place;
  final String screenType;
  final String latitude;
  final String longitude;
  String? id;
  final bool isEdit;
  // String? houseNo;
  // String? building;
  // String? landmark;
  String? label;

  AddAddress({
    super.key,
    required this.place,
    required this.screenType,
    required this.latitude,
    this.id,
    required this.isEdit,
    // this.houseNo,
    // this.building,
    // this.landmark,
    this.label,
    required this.longitude,
  });

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final Set<Marker> markers = {};

  static String selectedLabel = '';
  static TextEditingController houseNoController = TextEditingController();
  static TextEditingController buildingController = TextEditingController();
  static TextEditingController landmarkController = TextEditingController();
  static String lat = "";
  static String long = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressBloc(),
      child: BlocConsumer<AddAddressBloc, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressSaveSuccess) {
            showSuccessDialog(
              true,
              state.addAddressSaveResponse.message ?? "",
              "${widget.place.name} ,${widget.place.subLocality}, ${widget.place.locality}, ${widget.place.administrativeArea}, ${widget.place.postalCode}, ${widget.place.country}",
              selectedLabel,
              widget.screenType,
              context,
            );
            houseNoController.clear();
            buildingController.clear();
            landmarkController.clear();
            selectedLabel = "";
          } else if (state is SelectedLabelState) {
            selectedLabel = state.label;
          } else if (state is AddAddressTypeingState) {
            houseNoController.clear();
            buildingController.clear();
            landmarkController.clear();
            selectedLabel = "";
            houseNo = "";
            building = "";
            landmark = "";
            if (state.screenType == "editaddress") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YourLocationScreen(
                      lat: widget.latitude,
                      long: widget.longitude,
                      screenType: "change",
                    );
                  },
                ),
              );
            } else if (state.screenType == "change") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YourLocationScreen(
                      lat: widget.latitude,
                      long: widget.longitude,
                      screenType: "change",
                    );
                  },
                ),
              );
            }
          } else if (state is AddAddressErrorState) {
            debugPrint(state.errorMsg);
          }
        },
        builder: (context, state) {
          if (state is AddAddressInitialState) {
            lat = "";
            long = "";
            selectedLabel = widget.label ?? "";
            WidgetsBinding.instance.addPostFrameCallback((_) {
              houseNoController.text = houseNo;
              buildingController.text = building;
              landmarkController.text = landmark;
              lat = widget.latitude;
              long = widget.longitude;
            });

            markers.add(
              Marker(
                markerId: MarkerId('unique_id'),
                position: LatLng(
                  double.parse(widget.latitude),
                  double.parse(widget.longitude),
                ),
                infoWindow: InfoWindow(
                  title: 'My Marker',
                  snippet: 'Some info here',
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: AddAddressStyles.backgroundColor,
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
                "Add Address Details",
                style: TextStyle(color: headerComponentsColor),
              ),
            ),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AddAddressStyles.maxWidth,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AddAddressStyles.defaultPadding,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildMapPreview(context),
                          const SizedBox(height: 18),
                          _buildLocationInfo(
                            widget.place,
                            context.read<AddAddressBloc>(),
                            context,
                          ),
                          const SizedBox(height: 22),
                          _buildAddressForm(
                            context.read<AddAddressBloc>(),
                            context,
                          ),
                        ],
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

  Widget _buildMapPreview(context) {
    return Container(
      height: 323,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          onTap: (argument) {
            debugPrint(widget.screenType);
            if (widget.screenType == "editaddress") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YourLocationScreen(
                      lat: widget.latitude,
                      long: widget.longitude,
                      screenType: widget.screenType,
                    );
                  },
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(
              double.parse(widget.latitude),
              double.parse(widget.longitude),
            ),
            zoom: 20.0,
          ),
          onMapCreated: (GoogleMapController controller) {},
          markers: markers,
          // onCameraIdle: () {
          //   context.read<LocationBloc>().add(GetLatLonOnIdleEvent(
          //       latitude: latitude, longitude: longitude));
          // },
          // onCameraMove: (CameraPosition position) {
          //   context.read<LocationBloc>().add(GetLatLonEvent(
          //       latitude: position.target.latitude.toString(),
          //       longitude: position.target.longitude.toString()));
          // },
        ) /*   ImageNetwork(url:
          "https://cdn.builder.io/api/v1/image/assets/TEMP/08c56c190f2fda8733801f3fb8dd6154df55c0368b56a26bb54f2a751577ff14?placeholderIfAbsent=true&apiKey=479ee9553c984302af0d67c8f0a948e9",
          fit: BoxFit.cover,
          width: double.infinity,
        ), */,
      ),
    );
  }

  Widget _buildLocationInfo(
    Placemark place,
    AddAddressBloc addAddressBloc,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              place.subLocality == ""
                  ? SizedBox()
                  : Text(
                      place.subLocality ?? "",
                      style: AddAddressStyles.locationTitleStyle,
                    ),
              Text(
                "${place.name}${place.name == "" ? "" : ","}${place.subLocality}${place.subLocality == "" ? "" : ","} ${place.locality}${place.locality == "" ? "" : ","} ${place.administrativeArea}${place.administrativeArea == "" ? "" : ","} ${place.postalCode}${place.postalCode == "" ? "" : ","} ${place.country}",
                style: AddAddressStyles.locationSubtitleStyle,
              ),
            ],
          ),
        ),
        const SizedBox(width: 49),
        OutlinedButton(
          onPressed: () {
            debugPrint(widget.screenType);
            if (widget.screenType == "editaddress") {
              addAddressBloc.add(TypeEvent(screenType: widget.screenType));
            } else if (widget.screenType == "change") {
              addAddressBloc.add(TypeEvent(screenType: widget.screenType));
            } else {
              Navigator.pop(context);
            }
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AddAddressStyles.primaryGreen),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          ),
          child: const Text(
            'Change',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressForm(AddAddressBloc addAddressBloc, context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildInputField('House No. & Floor', houseNoController, context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('House No. & Floor', style: AddAddressStyles.labelStyle),
              const SizedBox(height: 4),
              TextFormField(
                controller: houseNoController,
                cursorColor: appColor,
                decoration: InputDecoration(
                  hintText: 'Enter Details',
                  hintStyle: AddAddressStyles.inputStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor), // Default border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused & error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // _buildInputField('Building & Block No.', buildingController, context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Building & Block No.', style: AddAddressStyles.labelStyle),
              const SizedBox(height: 4),
              TextFormField(
                controller: buildingController,
                cursorColor: appColor,
                decoration: InputDecoration(
                  hintText: 'Enter Details',
                  hintStyle: AddAddressStyles.inputStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor), // Default border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused & error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // _buildInputField(
          //   'Landmark & Area name(Optional)',
          //   landmarkController,
          //   context,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Landmark & Area name(Optional)',
                style: AddAddressStyles.labelStyle,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: landmarkController,
                cursorColor: appColor,
                decoration: InputDecoration(
                  hintText: 'Enter Details',
                  hintStyle: AddAddressStyles.inputStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor), // Default border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appColor,
                    ), // Border when focused & error
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          const SizedBox(height: 25),
          _buildAddressLabels(addAddressBloc),
          const SizedBox(height: 25),
          _buildSaveButton(addAddressBloc, context),
          const SizedBox(height: 43),
        ],
      ),
    );
  }

  Widget _buildAddressLabels(AddAddressBloc addAddressBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Address Label',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AddAddressStyles.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildLabelButton('Home', addAddressBloc),
            const SizedBox(width: 24),
            _buildLabelButton('Work', addAddressBloc),
            const SizedBox(width: 24),
            _buildLabelButton('Other', addAddressBloc),
          ],
        ),
      ],
    );
  }

  Widget _buildLabelButton(String label, AddAddressBloc addAddressBloc) {
    final isSelected = selectedLabel == label;
    return SizedBox(
      height: 35,
      width: 100,
      child: OutlinedButton(
        onPressed: () {
          addAddressBloc.add(SelectLabelEvent(label: label));
        },
        style: AddAddressStyles.addressLabelButtonStyle.copyWith(
          backgroundColor: isSelected
              ? WidgetStateProperty.all(backgroundTileColor)
              : WidgetStateProperty.all(Colors.transparent),
          foregroundColor: isSelected
              ? WidgetStateProperty.all(Colors.white)
              : WidgetStateProperty.all(AddAddressStyles.borderColor),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSaveButton(AddAddressBloc addAddressBloc, context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (houseNoController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Enter House No. & Floor")),
            );
          } else if (selectedLabel == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please select Address Label")),
            );
          } else {
            widget.isEdit
                ? addAddressBloc.add(
                    UpdateAddressEvent(
                      id: addressId,
                      userId: userId,
                      label: selectedLabel,
                      houseNo: houseNoController.text,
                      building: buildingController.text,
                      landMark: landmarkController.text,
                      area: widget.place.subLocality == ""
                          ? widget.place.name.toString()
                          : widget.place.subLocality.toString(),
                      city: widget.place.locality.toString(),
                      state: widget.place.subAdministrativeArea.toString() == ""
                          ? "State"
                          : widget.place.subAdministrativeArea.toString(),
                      pinCode: widget.place.postalCode.toString(),
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                  )
                : addAddressBloc.add(
                    SaveAddressEvent(
                      userId: userId,
                      label: selectedLabel,
                      houseNo: houseNoController.text,
                      building: buildingController.text,
                      landMark: landmarkController.text,
                      area: widget.place.subLocality == ""
                          ? widget.place.name.toString()
                          : widget.place.subLocality.toString(),
                      city: widget.place.locality.toString(),
                      state: widget.place.subAdministrativeArea.toString() == ""
                          ? "State"
                          : widget.place.subAdministrativeArea.toString(),
                      pinCode: widget.place.postalCode.toString(),
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                  );
          }
          // showSuccessDialog(context);
          // if (_formKey.currentState!.validate()) {
          //   // Handle save address
          // }
        },
        style: AddAddressStyles.saveButtonStyle,
        child: const Text(
          'Save Address',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// class AddAddress extends StatefulWidget {
//   final Placemark place;

//   const AddAddress({super.key, required this.place});

//   @override
//   State<AddAddress> createState() => _AddAddressState();
// }

// class _AddAddressState extends State<AddAddress> {
//   String selectedLabel = '';
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AddAddressStyles.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_new,
//               color: whitecolor,
//               size: 16,
//             )),
//         elevation: 0,
//         title: Text("Add Address Details"),
//       ),
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints:
//               const BoxConstraints(maxWidth: AddAddressStyles.maxWidth),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AddAddressStyles.defaultPadding,
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     _buildMapPreview(),
//                     const SizedBox(height: 18),
//                     _buildLocationInfo(place),
//                     const SizedBox(height: 22),
//                     _buildAddressForm(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMapPreview() {
//     return Container(
//       height: 323,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child:  ImageNetwork(url:
//           "https://cdn.builder.io/api/v1/image/assets/TEMP/08c56c190f2fda8733801f3fb8dd6154df55c0368b56a26bb54f2a751577ff14?placeholderIfAbsent=true&apiKey=479ee9553c984302af0d67c8f0a948e9",
//           fit: BoxFit.cover,
//           width: double.infinity,
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationInfo(Placemark place) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 place.subLocality ?? "",
//                 style: AddAddressStyles.locationTitleStyle,
//               ),
//               Text(
//                 "${place.name} ,${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}",
//                 style: AddAddressStyles.locationSubtitleStyle,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 49),
//         OutlinedButton(
//           onPressed: () {},
//           style: OutlinedButton.styleFrom(
//             side: const BorderSide(color: AddAddressStyles.primaryGreen),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
//           ),
//           child: const Text(
//             'Change',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddressForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildInputField('House No. & Floor'),
//           const SizedBox(height: 8),
//           _buildInputField('Building & Block No.'),
//           const SizedBox(height: 8),
//           _buildInputField('Landmark & Area name(Optional)'),
//           const SizedBox(height: 25),
//           _buildAddressLabels(),
//           const SizedBox(height: 25),
//           _buildSaveButton(),
//           const SizedBox(height: 43),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputField(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: AddAddressStyles.labelStyle,
//         ),
//         const SizedBox(height: 4),
//         TextFormField(
//           decoration: InputDecoration(
//             hintText: 'Enter Details',
//             hintStyle: AddAddressStyles.inputStyle,
//             border: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(AddAddressStyles.borderRadius),
//               borderSide: const BorderSide(
//                 color: AddAddressStyles.borderColor,
//               ),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 10,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAddressLabels() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Add Address Label',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AddAddressStyles.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             _buildLabelButton('Home'),
//             const SizedBox(width: 24),
//             _buildLabelButton('Work'),
//             const SizedBox(width: 24),
//             _buildLabelButton('Other'),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildLabelButton(String label) {
//     final isSelected = selectedLabel == label;
//     return SizedBox(
//       width: 100,
//       child: OutlinedButton(
//         onPressed: () {
//           // setState(() {
//           //   selectedLabel = label;
//           // });
//         },
//         style: AddAddressStyles.addressLabelButtonStyle.copyWith(
//           backgroundColor: isSelected
//               ? WidgetStateProperty.all(AddAddressStyles.primaryGreen)
//               : WidgetStateProperty.all(Colors.transparent),
//           foregroundColor: isSelected
//               ? WidgetStateProperty.all(Colors.white)
//               : WidgetStateProperty.all(AddAddressStyles.borderColor),
//         ),
//         child: Text(
//           label,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ),
//     );
//   }

//   Widget _buildSaveButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           showSuccessDialog(context);
//           // if (_formKey.currentState!.validate()) {
//           //   // Handle save address
//           // }
//         },
//         style: AddAddressStyles.saveButtonStyle,
//         child: const Text(
//           'Save Address',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }
