import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/cart/update_cart_response_model.dart';
import 'package:sodakkuapp/presentation/cart/cart_bloc.dart';
import 'package:sodakkuapp/presentation/cart/cart_event.dart';
import 'package:sodakkuapp/presentation/cart/cart_state.dart';
import 'package:sodakkuapp/presentation/location/location_screen.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/presentation/widgets/cart/cart_section_container.dart';
import 'package:sodakkuapp/presentation/widgets/cart/delivery_instruction_box.dart';
import 'package:sodakkuapp/presentation/widgets/cart/delivery_tip_styles.dart';

class CartScreen extends StatelessWidget {
  final String fromScreen;
  const CartScreen({super.key, required this.fromScreen});

  static final List<int> tipOptions = [10, 20, 30];
  static CartResponse cartResponse = CartResponse();
  static String tipAmount = "0";
  static bool expantion = false;
  static bool isOneSelected = false;
  static bool isTwoSelected = false;
  static String address = "";
  static String locationType = "";
  static String deliveryIns = "";
  static TextEditingController additionalNote = TextEditingController();
  static UpdateCartResponse updateCartResponse = UpdateCartResponse();

  static List<SavedAddress>? savedAddressList = [];

  void showSavedAddressBottomSheet(BuildContext context, CartBloc cartBloc) {
    showModalBottomSheet(
      backgroundColor: whitecolor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      //  isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              //  height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LocationScreen(screenType: 'screen');
                          },
                        ),
                      ).then((value) {
                        cartBloc.add(
                          PlaceAddressEvent(
                            locationType: value?[1] ?? "",
                            address: value?[0] ?? "",
                          ),
                        );
                        // locationType = value[1];
                        // address = value[0];
                        // debugPrint(value[1]);
                      });
                    },
                    child: Row(
                      spacing: 3,
                      children: [
                        Image.asset(addIcon, color: appColor),
                        Text(
                          "Add Address",
                          style: TextStyle(
                            fontSize: 16,
                            color: appColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(
                    "Saved Address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(),
                  Text(
                    "You are currently near",
                    style: TextStyle(
                      fontSize: 16,
                      color: appColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: savedAddressList!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cartBloc.add(
                                PlaceAddressEvent(
                                  locationType:
                                      savedAddressList![index].label ?? "",
                                  address:
                                      "${savedAddressList![index].details!.houseNo}, ${savedAddressList![index].details!.building}, ${savedAddressList![index].details!.landmark}, ${savedAddressList![index].details!.area}, ${savedAddressList![index].details!.city}, ${savedAddressList![index].details!.state}, ${savedAddressList![index].details!.pincode}",
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: Row(
                              spacing: 20,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(locIcon, color: appColor),
                                Expanded(
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        savedAddressList![index].label ?? "",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${savedAddressList![index].details!.houseNo}, ${savedAddressList![index].details!.building}, ${savedAddressList![index].details!.landmark}, ${savedAddressList![index].details!.area}, ${savedAddressList![index].details!.city}, ${savedAddressList![index].details!.state}, ${savedAddressList![index].details!.pincode}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ) /* .whenComplete(() => context.read<BottomSheetBloc>().add(HideBottomSheetEvent())) */; // Hide when dismissed
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is AddButtonClickedState) {
            cartResponse.items![state.selectedIndex].quantity =
                (cartResponse.items![state.selectedIndex].quantity ?? 0) + 1;
            context.read<CartBloc>().add(
              AddItemInCartApiEvent(
                userId: userId,
                productId:
                    cartResponse.items![state.selectedIndex].productId!.id ??
                    "",
                quantity: 1,
                variantLabel:
                    cartResponse.items![state.selectedIndex].variantLabel ?? "",
                imageUrl:
                    cartResponse.items![state.selectedIndex].imageUrl ?? "",
                price: cartResponse.items![state.selectedIndex].price ?? 0,
                discountPrice:
                    cartResponse.items![state.selectedIndex].discountPrice ?? 0,
                delivaryInstructions: "",
                addNotes: "",
              ),
            );
          } else if (state is RemoveButtonClickedState) {
            // cartResponse.items![state.selectedIndex].quantity =
            //     (cartResponse.items![state.selectedIndex].quantity ?? 0) - 1;
            context.read<CartBloc>().add(
              RemoveItemInCartApiEvent(
                userId: userId,
                productId:
                    cartResponse.items![state.selectedIndex].productId!.id ??
                    "",
                quantity: 1,
                variantLabel:
                    cartResponse.items![state.selectedIndex].variantLabel ?? "",
                deliveryTip: 0,
                handlingCharges: 0,
              ),
            );
          } else if (state is ItemAddedToCartState) {
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
          } else if (state is ItemRemovedToCartState) {
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
          } else if (state is CartDataSuccess) {
            cartResponse = state.cartResponse;
            debugPrint(cartResponse.items!.length.toString());
            if (cartResponse.items!.isEmpty) {
              tipAmount = "0";
              cartCount = 0;
              isOneSelected = false;
              isTwoSelected = false;
            } else {
              tipAmount = cartResponse.billSummary!.deliveryTip.toString();
            }
            // debugPrint(state.cartResponse.billSummary!..toString());
          } else if (state is SelectedTipState) {
            tipAmount = state.amount;
            context.read<CartBloc>().add(
              UpdateDeliveryTip(tip: tipAmount, userid: userId),
            );
            // context.read<CartBloc>().add(UpdateCartDataEvent(
            //     userId: userId,
            //     deliveryInstructions: deliveryIns,
            //     addNotes: additionalNote.text,
            //     deliveryTip: state.amount,
            //     deliveryFee: "0"));
          } else if (state is AddressFetchedSuccessState) {
            locationType = state.loctionType;
            address = state.address;
          } else if (state is PayExpantionState) {
            expantion = state.isExpand;
          } else if (state is DelivaryInstructionSelectState) {
            isOneSelected = state.one;
            isTwoSelected = state.two;
          } else if (state is SavedAddressFetchedSuccess) {
            savedAddressList = [];
            savedAddressList = state.getSavedAddressResponse.data;
            if (state.time == "initial") {
              locationType = savedAddressList![0].label ?? "";
              address =
                  "${savedAddressList![0].details!.houseNo}, ${savedAddressList![0].details!.building}, ${savedAddressList![0].details!.landmark}, ${savedAddressList![0].details!.area}, ${savedAddressList![0].details!.city}, ${savedAddressList![0].details!.state}, ${savedAddressList![0].details!.pincode}";
            } else {
              showSavedAddressBottomSheet(context, context.read<CartBloc>());
            }
          } else if (state is PlaceAddressState) {
            locationType = state.locationType;
            address = state.address;
          } else if (state is UpdateCartStateSuccess) {
            updateCartResponse = state.updateCartResponse;
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
          } else if (state is UpdateDeliveryTipApiSuccessState) {
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
          }
        },
        builder: (context, state) {
          if (state is CartInitialState) {
            cartResponse = CartResponse();
            cartResponse.items = [];
            savedAddressList = [];
            context.read<CartBloc>().add(GetCartDetailsEvent(userId: userId));
            context.read<CartBloc>().add(
              GetSavedAddressFromApiEvent(time: "initial", userId: userId),
            );
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            //    circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is CartLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: headerColor,
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    if (fromScreen == "home") {
                      Navigator.pushNamed(context, '/home');
                      selectedIndex = 0;
                    } else if (fromScreen == "productdetail") {
                      Navigator.pop(context);
                    } else if (fromScreen == "productlist") {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                    context.read<CartBloc>().add(SelectTipEvent(amount: "0"));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: headerComponentsColor,
                    size: 16,
                  ),
                ),
                actions: [
                  cartResponse.items!.isEmpty
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/home');
                            selectedIndex = 1;
                          },
                          child: Center(
                            child: Container(
                              // height: 20,
                              clipBehavior: Clip.hardEdge,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: secondAppColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Add More",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
                elevation: headerElevation,
                title: Text(
                  "Cart",
                  style: TextStyle(color: headerComponentsColor),
                ),
              ),
              body:
                  cartResponse
                      .items!
                      .isEmpty /* || cartResponse.items![index]
                                                          .quantity ==
                                                      0
                                                  ?  */
                  ? SizedBox(
                      width: double.infinity,
                      //color: appColor,
                      child: Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(emptyCartImage),
                          Text(
                            "Your cart is empty",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.pop(context);
                                Navigator.pushNamed(context, '/home');
                                selectedIndex = 1;
                                context.read<CartBloc>().add(
                                  SelectTipEvent(amount: "0"),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text(
                                'Browse Now',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // constraints: const BoxConstraints(maxWidth: 430),
                      margin: const EdgeInsets.symmetric(
                        horizontal: BorderSide.strokeAlignCenter,
                      ),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(
                              bottom: 80,
                            ), // Add padding to avoid overlap with the fixed container
                            child: Column(
                              spacing: 10,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/ApplyingCouponScreen',
                                    );
                                  },
                                  child: CartSectionContainer(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          couponImage,
                                          width: 32,
                                          height: 32,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            'View Coupons & Offers',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF444444),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFF444444),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: CartSectionContainer(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 7,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cartResponse.items!.length,
                                      itemBuilder: (context, index) {
                                        // cartCount = cartResponse.items!.length;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 9,
                                          ),
                                          child: Row(
                                            children: [
                                              cartResponse
                                                          .items![index]
                                                          .imageUrl ==
                                                      ""
                                                  ? SizedBox()
                                                  : NetworkImageWidget(
                                                      url:
                                                          cartResponse
                                                              .items![index]
                                                              .imageUrl ??
                                                          "",
                                                      width: 65,
                                                      height: 65,
                                                      fit: BoxFit.fitHeight,
                                                    ),

                                              // Image.network(
                                              //     cartResponse.items![index]
                                              //             .imageUrl ??
                                              //         "",
                                              //     width: 65,
                                              //     height: 65,
                                              //     fit: BoxFit.fitHeight,
                                              //   ),
                                              const SizedBox(width: 19),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cartResponse
                                                                  .items![index]
                                                                  .productId ==
                                                              null
                                                          ? ""
                                                          : cartResponse
                                                                    .items![index]
                                                                    .productId!
                                                                    .skuName ??
                                                                "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      cartResponse
                                                              .items![index]
                                                              .variantLabel ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: const Color(
                                                              0xFF666666,
                                                            ),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '₹',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: cartResponse
                                                                .items![index]
                                                                .discountPrice
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                    0xFF444444,
                                                                  ),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          TextSpan(text: " "),
                                                          TextSpan(
                                                            text: "₹",
                                                            style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                    0xFF777777,
                                                                  ),
                                                              fontSize: 10,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: cartResponse
                                                                .items![index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                    0xFF777777,
                                                                  ),
                                                              fontSize: 10,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width /
                                                    4,
                                                decoration: BoxDecoration(
                                                  color: appColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<CartBloc>()
                                                              .add(
                                                                RemoveItemFromCartEvent(
                                                                  selectedIndex:
                                                                      index,
                                                                ),
                                                              );
                                                        },
                                                        child: SizedBox(
                                                          height: 30,
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 28,
                                                      //  width: 22,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 8.0,
                                                                right: 8.0,
                                                              ),
                                                          child: Text(
                                                            cartResponse
                                                                .items![index]
                                                                .quantity
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color:
                                                                      appColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<CartBloc>()
                                                              .add(
                                                                AddButtonClikedEvent(
                                                                  selectedIndex:
                                                                      index,
                                                                ),
                                                              );
                                                        },
                                                        child: SizedBox(
                                                          height: 30,
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: ExpansionTile(
                                    iconColor: Colors.black,
                                    backgroundColor: whitecolor,
                                    collapsedBackgroundColor: whitecolor,
                                    shape: Border.all(color: whitecolor),
                                    childrenPadding: EdgeInsets.only(
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          "Delivery Partner Tip",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    subtitle: tipAmount == "0"
                                        ? Text(
                                            "This amount goes to your delivery partner.",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Text(
                                            "We thank you for your generosity!",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: DeliveryTipStyles
                                                  .successGreen,
                                            ),
                                          ),
                                    trailing: tipAmount == "0"
                                        ? null
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 7,
                                            ),
                                            decoration: BoxDecoration(
                                              color: backgroundTileColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Column(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: DeliveryTipStyles
                                                          .textGrey,
                                                      height: 15.6 / 12,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: tipAmount
                                                            .split(".")
                                                            .first
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              DeliveryTipStyles
                                                                  .textGrey,
                                                          height: 15.6 / 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  'Tipped',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: DeliveryTipStyles
                                                        .textGrey,
                                                    height: 15.6 / 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    showTrailingIcon: true,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            alignment: WrapAlignment
                                                .start, // Ensures items start from the left
                                            spacing: 6,
                                            runSpacing: 6,
                                            children: [
                                              ...tipOptions.map(
                                                (value) => IntrinsicWidth(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      debugPrint(
                                                        value.toString(),
                                                      );
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            SelectTipEvent(
                                                              amount: value
                                                                  .toString(),
                                                            ),
                                                          );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 7,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            tipAmount ==
                                                                value.toString()
                                                            ? backgroundTileColor
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              tipAmount ==
                                                                  value
                                                                      .toString()
                                                              ? appColor
                                                              : DeliveryTipStyles
                                                                    .borderGrey,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center, // Align contents properly
                                                        mainAxisSize: MainAxisSize
                                                            .min, // Avoid stretching
                                                        children: [
                                                          Image.asset(
                                                            tipsImage,
                                                            width: 18,
                                                            height: 14,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ), // Added spacing manually
                                                          Text(
                                                            '₹${value.toInt()}',
                                                            style: GoogleFonts.inter(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  DeliveryTipStyles
                                                                      .textGrey,
                                                              height: 15.6 / 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              IntrinsicWidth(
                                                child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          SelectTipEvent(
                                                            amount: "0",
                                                          ),
                                                        );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 7,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            letterSpacing: 0.8,
                                                            color: Colors.red,
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
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: ExpansionTile(
                                    backgroundColor: whitecolor,
                                    collapsedBackgroundColor: whitecolor,
                                    shape: Border.all(color: whitecolor),
                                    initiallyExpanded: expantion,
                                    childrenPadding: EdgeInsets.only(
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    title: expantion
                                        ? Row(
                                            spacing: 10,
                                            children: [
                                              Text(
                                                "Bill Summary",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Container(
                                                height: 28,
                                                padding: EdgeInsets.fromLTRB(
                                                  10,
                                                  0,
                                                  10,
                                                  0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: appColor,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Saved ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: whitecolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: '₹',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: whitecolor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: cartResponse
                                                              .billSummary!
                                                              .savings
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: whitecolor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 5,
                                            children: [
                                              Text(
                                                "To Pay",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                    subtitle: expantion
                                        ? null
                                        : Text(
                                            "Incl. All Taxes And changes",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                    trailing: FittedBox(
                                      child: Row(
                                        children: [
                                          if (!expantion)
                                            Text(
                                              "₹${cartResponse.billSummary!.totalBill.toString()}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          expantion
                                              ? Icon(
                                                  Icons
                                                      .keyboard_arrow_up_rounded,
                                                  color: Colors.black,
                                                )
                                              : Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Colors.black,
                                                ),
                                        ],
                                      ),
                                    ),
                                    onExpansionChanged: (value) {
                                      debugPrint(value.toString());
                                      context.read<CartBloc>().add(
                                        PayExpandBoolEvent(isExpand: value),
                                      );
                                    },
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Column(
                                              spacing: 15,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      spacing: 3,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Item Total & GST",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (
                                                                    BuildContext
                                                                    context,
                                                                  ) {
                                                                    return Dialog(
                                                                      backgroundColor:
                                                                          whitecolor,
                                                                      child: Container(
                                                                        width: MediaQuery.of(
                                                                          context,
                                                                        ).size.width,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              whitecolor,
                                                                          borderRadius: BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(
                                                                            20.0,
                                                                          ),
                                                                          child: Column(
                                                                            spacing:
                                                                                20,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min, // Prevent unnecessary height
                                                                            children: [
                                                                              Text(
                                                                                "Sodakku has no role to play in the taxes and charges being levied by the government",
                                                                                style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "Item Total",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                  ),
                                                                                  RichText(
                                                                                    text: TextSpan(
                                                                                      text: '₹',
                                                                                      style: const TextStyle(
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      children:
                                                                                          <
                                                                                            TextSpan
                                                                                          >[
                                                                                            TextSpan(
                                                                                              text: cartResponse.billSummary!.itemTotal.toString(),
                                                                                              style: const TextStyle(
                                                                                                fontSize: 12,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "GST on Handling Charge",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                  ),
                                                                                  RichText(
                                                                                    text: TextSpan(
                                                                                      text: '₹',
                                                                                      style: const TextStyle(
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      children:
                                                                                          <
                                                                                            TextSpan
                                                                                          >[
                                                                                            TextSpan(
                                                                                              text: cartResponse.billSummary!.gst.toString(),
                                                                                              style: const TextStyle(
                                                                                                fontSize: 12,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Divider(),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "Item Total & GST",
                                                                                    style: TextStyle(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  ),
                                                                                  RichText(
                                                                                    text: TextSpan(
                                                                                      text: '₹',
                                                                                      style: const TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      children:
                                                                                          <
                                                                                            TextSpan
                                                                                          >[
                                                                                            TextSpan(
                                                                                              text: cartResponse.billSummary!.subtotalWithGst.toString(),
                                                                                              style: const TextStyle(
                                                                                                fontSize: 14,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                            );
                                                          },
                                                          child: Image.asset(
                                                            gstIcon,
                                                            height: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '₹',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '${cartResponse.billSummary!.itemTotal! + cartResponse.billSummary!.gst!.toInt()}',
                                                            style:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .titleMedium,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Handling charge",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Poppins Regular',
                                                        color: Color(
                                                          0xFF666666,
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '₹',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Color(
                                                            0xFF666666,
                                                          ),
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: cartResponse
                                                                .billSummary!
                                                                .handlingCharges
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins Regular',
                                                              color: Color(
                                                                0xFF666666,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Delivery Fee",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Poppins Regular',
                                                        color: Color(
                                                          0xFF666666,
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '₹',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Color(
                                                            0xFF666666,
                                                          ),
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: cartResponse
                                                                .billSummary!
                                                                .deliveryFee
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins Regular',
                                                              color: Color(
                                                                0xFF666666,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Delivery Tip",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Poppins Regular',
                                                        color: Color(
                                                          0xFF666666,
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: '₹',
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Color(
                                                            0xFF666666,
                                                          ),
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: cartResponse
                                                                .billSummary!
                                                                .deliveryTip
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins Regular',
                                                              color: Color(
                                                                0xFF666666,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Total Bill",
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: '₹',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: cartResponse
                                                            .billSummary!
                                                            .totalBill
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CartSectionContainer(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery Instructions',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF222222),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Delivery partner will be notified',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 11),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          spacing: 15,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context.read<CartBloc>().add(
                                                  DeliveryInstructionSelectEvent(
                                                    one: !isOneSelected,
                                                    two: isTwoSelected,
                                                  ),
                                                );
                                                deliveryIns =
                                                    "No Contact Delivery";
                                              },
                                              child: DeliveryInstructionBox(
                                                icon: ncdsvg,
                                                title: 'No Contact Delivery',
                                                subtitle:
                                                    'Delivery partner will leave your order at your door',
                                                isSelected: isOneSelected,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context.read<CartBloc>().add(
                                                  DeliveryInstructionSelectEvent(
                                                    one: isOneSelected,
                                                    two: !isTwoSelected,
                                                  ),
                                                );
                                                deliveryIns =
                                                    "Do Not Ring The Bell";
                                              },
                                              child: DeliveryInstructionBox(
                                                icon: drbsvg,
                                                title: 'Do Not Ring The Bell',
                                                subtitle:
                                                    'Delivery partner will not ring the bell',
                                                isSelected: isTwoSelected,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CartSectionContainer(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        'Additional Note',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF222222),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: greyColor.shade500,
                                          ),
                                        ),
                                        //  width: size.width,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            //  Icon(Icons.search, color: Colors.black54),
                                            Expanded(
                                              child: TextFormField(
                                                controller: additionalNote,
                                                cursorColor: appColor,
                                                // keyboardType: TextInputType.phone,
                                                //maxLength: 10,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                  fillColor: Color(0xFFFFFFFF),
                                                  counterText: "",
                                                  hintText:
                                                      'Add your special notes on you order',
                                                  hintStyle: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                address == ""
                                    ? CartSectionContainer(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 29,
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: appColor,
                                                  size: 24,
                                                ),
                                                Text(
                                                  'Enter your Delivery Address',
                                                  style: GoogleFonts.poppins(
                                                    color: appColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            ElevatedButton(
                                              onPressed: () async {
                                                var address =
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return LocationScreen(
                                                            screenType:
                                                                'screen',
                                                          );
                                                        },
                                                      ),
                                                    );
                                                debugPrint(address[1] ?? "");
                                                if (!context.mounted) return;
                                                context.read<CartBloc>().add(
                                                  FetchAddressEvent(
                                                    locationType: address[1],
                                                    address: address[0],
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: appColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                ),
                                                minimumSize: const Size(
                                                  double.infinity,
                                                  50,
                                                ),
                                              ),
                                              child: Text(
                                                'Add Address to Proceed',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                // const SizedBox(
                                //     height: 80), // Bottom navigation padding
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              bottomNavigationBar:
                  address == "" ||
                      cartResponse.billSummary == null ||
                      cartResponse.items!.isEmpty
                  ? SizedBox()
                  : IntrinsicHeight(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          spacing: 12,
                          children: [
                            address == ""
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        GetSavedAddressFromApiEvent(
                                          time: "later",
                                          userId: userId,
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          locationType,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          " - ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ),
                                        Row(
                                          spacing: 4,
                                          children: [
                                            Icon(
                                              Icons.location_on_sharp,
                                              color: appColor,
                                              size: 15,
                                            ),
                                            Text(
                                              "Change",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: appColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            Row(
                              spacing: 30,
                              children: [
                                Column(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To Pay",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '₹',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: cartResponse
                                                .billSummary!
                                                .totalBill
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/payment');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                    ),
                                    child: Text(
                                      'CONTINUE TO PAYMENT',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(),
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
