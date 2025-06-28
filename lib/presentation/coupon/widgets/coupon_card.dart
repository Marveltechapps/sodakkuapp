import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sodakkuapp/utils/constant.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CouponCard extends StatelessWidget {
  final String couponCode;
  final String description;
  final bool isHighlighted;
  final VoidCallback onApply;

  const CouponCard({
    super.key,
    required this.couponCode,
    required this.description,
    this.isHighlighted = false,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isHighlighted ? AppColors.couponBackground : Colors.white,
        border: Border.all(color: AppColors.primaryGreen, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primaryGreen,
                          width: 1,
                          style: BorderStyle.none,
                        ),
                      ),
                      child: Text(couponCode, style: AppTextStyles.couponCode),
                    ),
                    const SizedBox(height: 5),
                    Text(description, style: AppTextStyles.couponDescription),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  minimumSize: const Size(94, 32),
                ),
                child: Text(
                  'APPLY',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.borderGrey, height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, color: greyColor),
              const SizedBox(width: 2),
              Text('MORE', style: AppTextStyles.moreText),
            ],
          ),
        ],
      ),
    );
  }
}
