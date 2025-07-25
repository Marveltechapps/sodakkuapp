import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final String weight;
  final String currentPrice;
  final String originalPrice;
  final int quantity;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.weight,
    required this.currentPrice,
    required this.originalPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          NetworkImageWidget(
            url: image,
            width: 65,
            height: 65,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 19),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF444444),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  weight,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF666666),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      currentPrice,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF444444),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      originalPrice,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF777777),
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 1),
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 25,
            child: Row(
              children: [
                const Icon(Icons.remove, color: Colors.white, size: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  //  padding: const EdgeInsets.symmetric(vertical: 2),
                  width: 37,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //  borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.add, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
