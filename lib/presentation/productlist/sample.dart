// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductGrid extends StatefulWidget {
//   final dynamic productStyleResponse;
//   final double itemWidth;
//   final double itemHeight;

//   const ProductGrid({
//     super.key,
//     required this.productStyleResponse,
//     required this.itemWidth,
//     required this.itemHeight,
//   });

//   @override
//   _ProductGridState createState() => _ProductGridState();
// }

// class _ProductGridState extends State<ProductGrid> {
//   Map<int, int> selectedVariants = {}; // Track selected variant per product

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: widget.itemWidth / widget.itemHeight,
//       ),
//       itemCount: widget.productStyleResponse.data!.length,
//       itemBuilder: (context, index) {
//         var product = widget.productStyleResponse.data![index];
//         var variants = product.variants ?? [];

//         if (variants.isEmpty) {
//           return Container(); // If no variants, show nothing (or handle differently)
//         }

//         int selectedVariantIndex = selectedVariants[index] ?? 0;
//         var selectedVariant = variants[selectedVariantIndex];

//         return Container(
//           width: widget.itemWidth,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 12.0),
//                         child:  ImageNetwork(url:
//                           selectedVariant.imageUrl ?? "",
//                           fit: BoxFit.contain,
//                           width: widget.itemWidth,
//                         ),
//                       ),
//                     ),
//                     if (selectedVariant.offer != null &&
//                         selectedVariant.offer!.isNotEmpty)
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           decoration: const BoxDecoration(
//                             color: appColor,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Text(
//                             selectedVariant.offer!,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.skuName ?? "",
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 6),

//                     // Dropdown to select variant
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 4, vertical: 8),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: const Color(0xFFAAAAAA)),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<int>(
//                           value: selectedVariantIndex,
//                           isDense: true,
//                           icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                               size: 15),
//                           onChanged: (newIndex) {
//                             setState(() {
//                               selectedVariants[index] = newIndex!;
//                             });
//                           },
//                           items: List.generate(
//                             variants.length,
//                             (i) => DropdownMenuItem(
//                               value: i,
//                               child: Text(
//                                 variants[i].label ?? "Unknown Size",
//                                 style: const TextStyle(
//                                     fontSize: 10, color: Colors.black),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 6),

//                     // Price Display
//                     Row(
//                       children: [
//                         Text(
//                           'Rs ${selectedVariant.discountPrice ?? ""}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         if (selectedVariant.price != null)
//                           Text(
//                             selectedVariant.price.toString(),
//                             style: const TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF777777),
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),

//                     // Quantity selector
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 1),
//                       decoration: BoxDecoration(
//                         color: const appColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       height: 27,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.remove,
//                               color: Colors.white, size: 16),
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 16),
//                             width: 37,
//                             decoration:
//                                 const BoxDecoration(color: Colors.white),
//                             child: Text(
//                               "1", // Quantity can be dynamically managed if needed
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.poppins(
//                                 color: const appColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const Icon(Icons.add, color: Colors.white, size: 16),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
