import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sodakkuapp/presentation/widgets/success_dialog_widget.dart';
import 'package:sodakkuapp/utils/constant.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/coupon_card.dart';

class ApplyingCouponScreen extends StatefulWidget {
  const ApplyingCouponScreen({super.key});

  @override
  State<ApplyingCouponScreen> createState() => _ApplyingCouponScreenState();
}

class _ApplyingCouponScreenState extends State<ApplyingCouponScreen> {
  final TextEditingController _couponController = TextEditingController();
  bool showError = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  // void _applyCoupon() {
  //   setState(() {
  //     _showError = _couponController.text.isEmpty;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
          "Add Coupons",
          style: TextStyle(color: headerComponentsColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor.shade500),
                      ),
                      //  width: size.width,
                      height: 50,
                      child: Row(
                        children: [
                          //  Icon(Icons.search, color: Colors.black54),
                          Expanded(
                            child: TextFormField(
                              cursorColor: appColor,
                              //  controller: searchController,
                              // keyboardType: TextInputType.,
                              // maxLength: 10,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFFFFFFF),
                                counterText: "",
                                hintText: 'Enter Coupon code',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
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
                  const SizedBox(width: 36),
                  GestureDetector(
                    onTap: () {
                      showSuccessDialog(
                        true,
                        "Coupon Applied!",
                        "",
                        "",
                        "",
                        context,
                      );
                    },
                    child: Text('APPLY', style: AppTextStyles.applyButtonText),
                  ),
                ],
              ),
            ),
            if (showError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Please enter a valid coupon code',
                  style: AppTextStyles.errorText,
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      couponImage,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                    Text(
                      "No Available Coupons",
                      style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                    ),
                    SizedBox(height: 150),
                  ],
                ),
              ),
            ),

            // Text(
            //   'Available Coupons',
            //   style: AppTextStyles.sectionTitle,
            // ),
            // const SizedBox(height: 12),
            Visibility(
              visible: false,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CouponCard(
                    couponCode: 'FRS899',
                    description: 'Add Products worth ₹299 to avail this deal',
                    isHighlighted: index == 0,
                    onApply: () {
                      Navigator.pop(context);
                      showSuccessDialog(true, "Success", "", "", "", context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
