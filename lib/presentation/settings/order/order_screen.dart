import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:sodakkuapp/presentation/settings/order/order_bloc.dart';
import 'package:sodakkuapp/presentation/settings/order/order_event.dart';
import 'package:sodakkuapp/presentation/settings/order/order_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static bool isInitial = true;
  static bool isReviewSubmitted = false;
  static TextEditingController commentsController = TextEditingController();
  static double ratingValue = 0;
  static List<bool> isSelected = [false, false, false, false, false, false];

  void showRatingBottomSheet(BuildContext context, OrderBloc orderBloc) {
    ratingValue = 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: orderBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return SizedBox(
                    height: isInitial || isReviewSubmitted
                        ? MediaQuery.of(context).size.height * 0.50
                        : MediaQuery.of(context).size.height * 0.85,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        //  controller: scrollController,
                        child: Column(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isInitial || isReviewSubmitted
                                    ? null
                                    : Color(0xFFF3FBE1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 25.0,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rate your Order",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    if (isReviewSubmitted)
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(crossIcon),
                                      ),
                                    if (!isReviewSubmitted)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Colors.green.shade100,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 6,
                                              bottom: 6,
                                            ),
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                Text(
                                                  "Skip",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: appColor,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: appColor,
                                                  size: 14,
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
                            if (isInitial || isReviewSubmitted)
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(rateBanner),
                              ),
                            if (!isReviewSubmitted)
                              Text(
                                "How was your Order?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            // if (!isReviewSubmitted && isInitial)
                            //   InkWell(
                            //     onTap: () {
                            //       orderBloc.add(AddReviewEvent(
                            //           isReviewSelected: true,
                            //           isReviewSubmitted: false));
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: List.generate(5, (index) {
                            //         return Icon(
                            //           Icons.star,
                            //           color: isInitial
                            //               ? Colors.grey
                            //               : index < 3
                            //                   ? Colors.red
                            //                   : Colors.grey,
                            //           size: 30,
                            //         );
                            //       }),
                            //     ),
                            //   ),
                            StarRating(
                              rating: ratingValue,
                              allowHalfRating: false,
                              color: Color(0xFFED232A),
                              size: 30,
                              emptyIcon: Icons.star_border,
                              borderColor: Color(0xFFED232A),
                              onRatingChanged: (rating) {
                                ratingValue = rating;
                                orderBloc.add(RatingEvent(rating: ratingValue));
                                orderBloc.add(
                                  AddReviewEvent(
                                    isReviewSelected: true,
                                    isReviewSubmitted: false,
                                  ),
                                );
                              },
                            ),
                            // if (!isInitial)
                            //   StarRating(
                            //       rating: ratingValue,
                            //       allowHalfRating: false,
                            //       color: Color(0xFFED232A),
                            //       size: 30,
                            //       emptyIcon: Icons.star_border,
                            //       borderColor: Color(0xFFED232A),
                            //       onRatingChanged: (rating) {
                            //         ratingValue = rating;
                            //         orderBloc
                            //             .add(RatingEvent(rating: ratingValue));
                            //       }),
                            if (isReviewSubmitted) SizedBox(height: 10),
                            if (isReviewSubmitted)
                              Text(
                                "Thanks for your Feedback !",
                                style: TextStyle(
                                  color: greenColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (!isInitial) Divider(),
                            if (!isInitial)
                              Text(
                                "What will we do well?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            if (!isInitial) SizedBox(height: 10),
                            if (!isInitial)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[0],
                                                  index: 0,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[0]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                oneIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Product Selection or availability",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[1],
                                                  index: 1,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Border color
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[1]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                twoIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Delivery Experience",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[2],
                                                  index: 2,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Border color
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[2]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                threeIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Product Quality",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!isInitial)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[3],
                                                  index: 3,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Border color
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[3]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                fourIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Missing or incorrect item",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[4],
                                                  index: 4,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Border color
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[4]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                fiveIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "High Prices",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 10,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                SelectOptionEvent(
                                                  isSelected: !isSelected[5],
                                                  index: 5,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Border color
                                                  width: 1, // Border width
                                                ),
                                                color: isSelected[5]
                                                    ? Color(0xFFCAEBB1)
                                                    : Colors.white,
                                              ),
                                              child: Image.asset(
                                                sixIcon,
                                                height: 80,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Delay in Delivery",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!isInitial) SizedBox(height: 20),
                            if (!isInitial)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: greyColor.shade300,
                                    ),
                                  ),
                                  //  width: size.width,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: commentsController,
                                          cursorColor: appColor,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xFFFFFFFF),
                                            counterText: "",
                                            hintText: "Comments / Suggestions?",
                                            hintStyle: TextStyle(
                                              color: Colors.black54,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (!isInitial) SizedBox(height: 20),
                            if (!isInitial)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appColor,
                                    ),
                                    onPressed: () {
                                      orderBloc.add(
                                        AddReviewEvent(
                                          isReviewSubmitted: true,
                                          isReviewSelected: false,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Send",
                                      style: TextStyle(color: Colors.white),
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
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is ReviewSelectedState) {
            isInitial = !state.isReviewSelected;
            isReviewSubmitted = state.isReviewSubmitted;
            debugPrint(isInitial.toString());
          } else if (state is SelectOptionState) {
            isSelected[state.index] = state.isSelected;
            debugPrint(isSelected.toString());
          } else if (state is RatingSelectedState) {
            ratingValue = state.rating;
            debugPrint(ratingValue.toString());
          }
        },
        builder: (context, state) {
          if (state is OrderInitialState) {
            isInitial = true;
            isReviewSubmitted = false;
          }
          return Scaffold(
            backgroundColor: whitecolor,
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
                "Orders",
                style: TextStyle(color: headerComponentsColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                child: Center(
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(emptyordersvg, fit: BoxFit.cover),
                      Text(
                        "No orders placed yet. Start exploring\nand items to your cart !",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF666666)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.pushNamed(context, '/home');
                            selectedIndex = 1;
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
