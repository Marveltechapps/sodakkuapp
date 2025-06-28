import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sodakkuapp/model/cart/cart_model.dart' as cart;
import 'package:sodakkuapp/model/category/product_detail_model.dart' as pdm;
import 'package:sodakkuapp/model/category/similar_product_response_model.dart';
import 'package:sodakkuapp/presentation/cart/cart_screen.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_bloc.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_event.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_state.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_menu.dart';
import 'package:sodakkuapp/presentation/search/search_screen.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final String screenType;
  const ProductDetailsScreen({
    required this.productId,
    required this.screenType,
    super.key,
  });

  static pdm.ProductDetailResponse productDetailResponse =
      pdm.ProductDetailResponse();
  static String errorMsg = '';
  static SimilarProductResponse similarProductResponse =
      SimilarProductResponse();
  // static spd.SimilarProductDetailResponse similarProductDetailResponse =
  //     spd.SimilarProductDetailResponse();
  static bool addButtonClicked = false;
  static int varientIndex = 0;
  static int similarvarientIndex = 0;
  static cart.CartResponse cartResponse = cart.CartResponse();
  static int cartCount = 0;
  static int totalAmount = 0;
  static dynamic selectedVariant;
  static dynamic selectedsimilarVariant;
  static int similarIndex = 0;

  void showProductBottomSheet(
    BuildContext context,
    String name,
    bool isSimilar,
    int similarIndex,
    List<dynamic> variant,
    ProductDetailBloc productDetailBloc,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: whitecolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: productDetailBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          spacing: 15,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: variant.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    // varientIndex =
                                    //     i; // Update the selected variant index
                                    // selectedVariant = productDetailResponse
                                    //     .data!.product!.variants![i];

                                    Navigator.pop(context);
                                    context.read<ProductDetailBloc>().add(
                                      LabelVarientItemEvent(
                                        productIndex: 0,
                                        varientIndex: i,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: whitecolor,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                variant[i].label ?? "",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                                maxLines: 2,
                                              ),
                                              Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '₹ ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: variant[i]
                                                              .discountPrice
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                '`Poppins`',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '₹ ',
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: variant[i].price
                                                              .toString(),
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 12,
                                                            color: Colors.grey,
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
                                        isSimilar
                                            ? similarProductResponse
                                                          .data![similarIndex]
                                                          .variants![i]
                                                          .cartQuantity ==
                                                      0
                                                  ? InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                              ProductDetailBloc
                                                            >()
                                                            .add(
                                                              AddButtonClikedEvent(
                                                                type:
                                                                    "similar_dialog",
                                                                index: i,
                                                                similarIndex:
                                                                    similarIndex,
                                                                isButtonPressed:
                                                                    true,
                                                              ),
                                                            );
                                                      },
                                                      child: Container(
                                                        width: 130,
                                                        height: 30,
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 1,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              similarProductResponse
                                                                      .data![similarIndex]
                                                                      .variants![i]
                                                                      .cartQuantity ==
                                                                  0
                                                              ? whitecolor
                                                              : appColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                          border: Border.all(
                                                            color: appColor,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Add",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  color:
                                                                      appColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  //  Container(
                                                  //   width: 130,
                                                  //   height: 30,
                                                  //   padding: const EdgeInsets
                                                  //       .symmetric(vertical: 1),
                                                  //   child: ElevatedButton(
                                                  //     style: ElevatedButton
                                                  //         .styleFrom(
                                                  //       backgroundColor:
                                                  //           whitecolor,
                                                  //       shape:
                                                  //           RoundedRectangleBorder(
                                                  //         side: BorderSide(
                                                  //             color: appColor),
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(20),
                                                  //       ),
                                                  //     ),
                                                  //     onPressed: () {
                                                  //       context
                                                  //           .read<
                                                  //               ProductDetailBloc>()
                                                  //           .add(AddButtonClikedEvent(
                                                  //               type:
                                                  //                   "similar_dialog",
                                                  //               index: i,
                                                  //               similarIndex:
                                                  //                   similarIndex,
                                                  //               isButtonPressed:
                                                  //                   true));
                                                  //     },
                                                  //     child: Text(
                                                  //       "Add",
                                                  //       style:
                                                  //           GoogleFonts.poppins(
                                                  //         color: appColor,
                                                  //         fontSize: 14,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // )
                                                  : Container(
                                                      width: 130,
                                                      height: 30,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 1,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                        border: Border.all(
                                                          color: appColor,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                      ProductDetailBloc
                                                                    >()
                                                                    .add(
                                                                      RemoveItemButtonClikedEvent(
                                                                        type:
                                                                            "similar_dialog",
                                                                        index:
                                                                            i,
                                                                        similarIndex:
                                                                            similarIndex,
                                                                        isButtonPressed:
                                                                            true,
                                                                      ),
                                                                    );
                                                              },
                                                              child: SizedBox(
                                                                height: 30,
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                            child: Center(
                                                              child: Text(
                                                                similarProductResponse
                                                                    .data![similarIndex]
                                                                    .variants![i]
                                                                    .cartQuantity
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.poppins(
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
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                      ProductDetailBloc
                                                                    >()
                                                                    .add(
                                                                      AddButtonClikedEvent(
                                                                        type:
                                                                            "similar_dialog",
                                                                        index:
                                                                            i,
                                                                        similarIndex:
                                                                            similarIndex,
                                                                        isButtonPressed:
                                                                            true,
                                                                      ),
                                                                    );
                                                              },
                                                              child: SizedBox(
                                                                height: 30,
                                                                child: Center(
                                                                  child: const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                            : productDetailResponse
                                                      .data!
                                                      .product!
                                                      .variants![i]
                                                      .userCartQuantity ==
                                                  0
                                            ? SizedBox(
                                                width: 100,
                                                height: 30,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: whitecolor,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color: appColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                          ProductDetailBloc
                                                        >()
                                                        .add(
                                                          AddButtonClikedEvent(
                                                            type: "dialog",
                                                            index: i,
                                                            similarIndex:
                                                                similarIndex,
                                                            isButtonPressed:
                                                                true,
                                                          ),
                                                        );
                                                  },
                                                  child: Text(
                                                    "Add",
                                                    style: GoogleFonts.poppins(
                                                      color: appColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 100,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: appColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: appColor,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                ProductDetailBloc
                                                              >()
                                                              .add(
                                                                RemoveItemButtonClikedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index: i,
                                                                  similarIndex:
                                                                      similarIndex,
                                                                  isButtonPressed:
                                                                      true,
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
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          productDetailResponse
                                                              .data!
                                                              .product!
                                                              .variants![i]
                                                              .userCartQuantity
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                color: appColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                ProductDetailBloc
                                                              >()
                                                              .add(
                                                                AddButtonClikedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index: i,
                                                                  similarIndex:
                                                                      similarIndex,
                                                                  isButtonPressed:
                                                                      true,
                                                                ),
                                                              );
                                                        },
                                                        child: SizedBox(
                                                          height: 30,
                                                          child: Center(
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            cartCount == 0
                                ? SizedBox()
                                : Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                          right: 18,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "$cartCount Item",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    color: whitecolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  " | ",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    color: whitecolor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: whitecolor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: totalAmount
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              '`Poppins`',
                                                          fontSize: 16,
                                                          color: whitecolor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return CartScreen(
                                                        fromScreen:
                                                            'productdetail',
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                spacing: 10,
                                                children: [
                                                  Image.asset(viewCartImage),
                                                  Text(
                                                    "View Cart",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: whitecolor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
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
      create: (context) => ProductDetailBloc(),
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state is ProductDetailSuccessState) {
            productDetailResponse = state.productDetailResponse;
            // debugPrint(productDetailResponse.data!.product!.skuName);
            similarProductResponse = SimilarProductResponse();
            context.read<ProductDetailBloc>().add(
              GetSimilarProductEvent(
                productId: productDetailResponse.data!.product!.id ?? "",
              ),
            );
            selectedVariant = productDetailResponse.data!.product!.variants!
                .firstWhere(
                  (variant) => (variant.userCartQuantity ?? 0) > 0,
                  orElse: () =>
                      productDetailResponse.data!.product!.variants![0],
                );
          } else if (state is UpdateSimilarProductIndexState) {
            similarvarientIndex = state.similarIndex;
          } else if (state is SimilarProductSuccessState) {
            similarProductResponse = state.similarProductResponse;
            // similarProductResponse.data![similarIndex].variants!
            //         .firstWhere(
            //           (variant) => (variant.userCartQuantity ?? 0) > 0,
            //           orElse: () => similarProductResponse
            //               .data![similarIndex].variants![0],
            //         )
            //         .label ??
            // "";
            selectedsimilarVariant = similarProductResponse
                .data![similarIndex]
                .variants!
                .firstWhere(
                  (variant) => (variant.cartQuantity ?? 0) > 0,
                  orElse: () =>
                      similarProductResponse.data![similarIndex].variants![0],
                );
          } /* else if (state is SimilarProductDetailSuccessState) {
            similarProductDetailResponse = state.similarProductDetailResponse;
          } */ else if (state is LabelChangedState) {
            // varientIndex = state.varientIndex;
            // debugPrint(productDetailResponse
            //     .data!.product!.variants![state.varientIndex].label);
            varientIndex = state.varientIndex;
            similarvarientIndex = state.varientIndex;
            selectedVariant =
                productDetailResponse.data!.product!.variants![varientIndex];
            selectedsimilarVariant = similarProductResponse
                .data![similarIndex]
                .variants![similarvarientIndex];
            debugPrint(
              productDetailResponse
                  .data!
                  .product!
                  .variants![state.varientIndex]
                  .label,
            );
          } else if (state is AddButtonClickedState) {
            addButtonClicked = state.isSelected;
            varientIndex = state.selectedIndexes;
            similarvarientIndex = state.selectedIndexes;
            if (state.type == "screen") {
              productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .userCartQuantity =
                  (productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .userCartQuantity ??
                      0) +
                  1;
              selectedVariant =
                  productDetailResponse.data!.product!.variants![varientIndex];

              context.read<ProductDetailBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId: productDetailResponse.data!.product!.id ?? "",
                  quantity: 1,
                  variantLabel:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .label ??
                      "",
                  imageUrl:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .imageUrl ??
                      "",
                  price:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .price ??
                      0,
                  discountPrice:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "dialog") {
              productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .userCartQuantity =
                  (productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .userCartQuantity ??
                      0) +
                  1;
              debugPrint(
                productDetailResponse
                    .data!
                    .product!
                    .variants![varientIndex]
                    .label
                    .toString(),
              );
              selectedVariant =
                  productDetailResponse.data!.product!.variants![varientIndex];
              context.read<ProductDetailBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId: productDetailResponse.data!.product!.id ?? "",
                  quantity: 1,
                  variantLabel:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .label ??
                      "",
                  imageUrl:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .imageUrl ??
                      "",
                  price:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .price ??
                      0,
                  discountPrice:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "similar") {
              similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity =
                  (similarProductResponse
                          .data![state.selectedIndexes]
                          .variants![similarvarientIndex]
                          .cartQuantity ??
                      0) +
                  1;
              selectedsimilarVariant = similarProductResponse
                  .data![similarIndex]
                  .variants![similarvarientIndex];
              context.read<ProductDetailBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId:
                      similarProductResponse
                          .data![state.similarIndex]
                          .similarProductId ??
                      "",
                  quantity: 1,
                  variantLabel:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .label ??
                      "",
                  imageUrl:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .imageUrl ??
                      "",
                  price:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .price ??
                      0,
                  discountPrice:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "similar_dialog") {
              similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity =
                  (similarProductResponse
                          .data![state.similarIndex]
                          .variants![similarvarientIndex]
                          .cartQuantity ??
                      0) +
                  1;
              selectedsimilarVariant = similarProductResponse
                  .data![similarIndex]
                  .variants![similarvarientIndex];
              context.read<ProductDetailBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId:
                      similarProductResponse
                          .data![state.similarIndex]
                          .similarProductId ??
                      "",
                  quantity: 1,
                  variantLabel:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .label ??
                      "",
                  imageUrl:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .imageUrl ??
                      "",
                  price:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .price ??
                      0,
                  discountPrice:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            }
            // itemCount.add(1);
          } else if (state is ItemAddedToCartState) {
            context.read<ProductDetailBloc>().add(
              GetSimilarProductEvent(
                productId: productDetailResponse.data!.product!.id ?? "",
              ),
            );
            context.read<ProductDetailBloc>().add(
              GetCartCountLengthEvent(userId: userId),
            );
          } else if (state is RemoveButtonClickedState) {
            varientIndex = state.selectedIndexes;
            similarvarientIndex = state.selectedIndexes;
            if (state.type == "screen") {
              productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .userCartQuantity ==
                      0
                  ? null
                  : productDetailResponse
                            .data!
                            .product!
                            .variants![varientIndex]
                            .userCartQuantity =
                        (productDetailResponse
                                .data!
                                .product!
                                .variants![varientIndex]
                                .userCartQuantity ??
                            0) -
                        1;
              selectedVariant =
                  productDetailResponse.data!.product!.variants![varientIndex];
              context.read<ProductDetailBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId: productDetailResponse.data!.product!.id ?? "",
                  variantLabel:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .label ??
                      "",
                  quantity: 1,
                  deliveryTip: 0,
                  handlingcharges: 0,
                ),
              );
            } else if (state.type == "dialog") {
              productDetailResponse
                      .data!
                      .product!
                      .variants![varientIndex]
                      .userCartQuantity =
                  (productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .userCartQuantity ??
                      0) -
                  1;
              debugPrint(
                productDetailResponse
                    .data!
                    .product!
                    .variants![varientIndex]
                    .label
                    .toString(),
              );
              selectedVariant =
                  productDetailResponse.data!.product!.variants![varientIndex];
              context.read<ProductDetailBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId: productDetailResponse.data!.product!.id ?? "",
                  variantLabel:
                      productDetailResponse
                          .data!
                          .product!
                          .variants![varientIndex]
                          .label ??
                      "",
                  quantity: 1,
                  deliveryTip: 0,
                  handlingcharges: 0,
                ),
              );
            } else if (state.type == "similar") {
              similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity =
                  (similarProductResponse
                          .data![state.similarIndex]
                          .variants![similarvarientIndex]
                          .cartQuantity ??
                      0) -
                  1;
              selectedsimilarVariant = similarProductResponse
                  .data![state.similarIndex]
                  .variants![similarvarientIndex];
              context.read<ProductDetailBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId:
                      similarProductResponse
                          .data![state.similarIndex]
                          .similarProductId ??
                      "",
                  variantLabel:
                      similarProductResponse
                          .data![state.selectedIndexes]
                          .variants![varientIndex]
                          .label ??
                      "",
                  quantity: 1,
                  deliveryTip: 0,
                  handlingcharges: 0,
                ),
              );
            } else if (state.type == "similar_dialog") {
              similarProductResponse
                      .data![state.similarIndex]
                      .variants![similarvarientIndex]
                      .cartQuantity =
                  (similarProductResponse
                          .data![state.similarIndex]
                          .variants![similarvarientIndex]
                          .cartQuantity ??
                      0) -
                  1;
              selectedsimilarVariant = similarProductResponse
                  .data![state.similarIndex]
                  .variants![similarvarientIndex];
              context.read<ProductDetailBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId:
                      similarProductResponse
                          .data![state.similarIndex]
                          .similarProductId ??
                      "",
                  variantLabel:
                      similarProductResponse
                          .data![state.similarIndex]
                          .variants![varientIndex]
                          .label ??
                      "",
                  quantity: 1,
                  deliveryTip: 0,
                  handlingcharges: 0,
                ),
              );
            }
          } else if (state is ItemRemovedToCartState) {
            context.read<ProductDetailBloc>().add(
              GetSimilarProductEvent(
                productId: productDetailResponse.data!.product!.id ?? "",
              ),
            );
            context.read<ProductDetailBloc>().add(
              GetCartCountLengthEvent(userId: userId),
            );
          } else if (state is CartCountLengthSuccessState) {
            cartResponse = state.cartResponse;
            cartCount = 0;
            if (state.cartResponse.items != null) {
              for (var i = 0; i < state.cartResponse.items!.length; i++) {
                cartCount =
                    cartCount + (state.cartResponse.items![i].quantity ?? 0);
              }
            }
            totalAmount = state.cartResponse.billSummary!.itemTotal ?? 0;
          } else if (state is ProductDetailErrorState) {
            errorMsg = state.errorMsg;
            debugPrint(state.errorMsg);
          }
        },
        builder: (context, state) {
          if (state is ProductDetailInitialState) {
            varientIndex = 0;
            similarvarientIndex = 0;
            productDetailResponse = pdm.ProductDetailResponse();
            context.read<ProductDetailBloc>().add(
              GetProductDetailEvent(
                mobileNo: phoneNumber,
                productId: productId,
              ),
            );
            context.read<ProductDetailBloc>().add(
              GetCartCountLengthEvent(userId: userId),
            );
          }

          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: false /*  state is ProductDetailLoadingState */,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  if (screenType == "back") {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductListMenuScreen(
                            title: title,
                            id: id,
                            isMainCategory: isMainCategory,
                            mainCatId: mainCatId,
                            isCategory: isCategory,
                            catId: catId,
                          );
                        },
                      ),
                    );
                  }
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: headerColor,
                  surfaceTintColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      if (screenType == "back") {
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductListMenuScreen(
                                title: title,
                                id: id,
                                isMainCategory: isMainCategory,
                                mainCatId: mainCatId,
                                isCategory: isCategory,
                                catId: catId,
                              );
                            },
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: headerComponentsColor,
                      size: 16,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(searchTitle: "All Categories"),
                          ),
                        );
                      },
                      icon: Icon(Icons.search, color: headerComponentsColor),
                    ),
                  ],
                  elevation: headerElevation,
                  title: Text("Product Detail"),
                ),
                bottomNavigationBar: cartCount == 0
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "$cartCount Item",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: whitecolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        " | ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: whitecolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '₹',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: whitecolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: totalAmount.toString(),
                                              style: TextStyle(
                                                fontFamily: '`Poppins`',
                                                fontSize: 16,
                                                color: whitecolor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/cart');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CartScreen(
                                              fromScreen: 'productdetail',
                                            );
                                          },
                                        ),
                                      ).then((value) {
                                        debugPrint("back to product detail");
                                        varientIndex = 0;
                                        similarvarientIndex = 0;
                                        productDetailResponse =
                                            pdm.ProductDetailResponse();
                                        if (!context.mounted) return;
                                        context.read<ProductDetailBloc>().add(
                                          GetProductDetailEvent(
                                            mobileNo: phoneNumber,
                                            productId: productId,
                                          ),
                                        );
                                        context.read<ProductDetailBloc>().add(
                                          GetCartCountLengthEvent(
                                            userId: userId,
                                          ),
                                        );
                                      });
                                    },
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Image.asset(viewCartImage),
                                        Text(
                                          "View Cart",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: whitecolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: productDetailResponse.data != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 15,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: whitecolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: ImageNetwork(
                                          url:
                                              productDetailResponse
                                                  .data!
                                                  .product!
                                                  .variants![varientIndex]
                                                  .imageUrl ??
                                              "",
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height /
                                              3,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Column(
                                        spacing: 15,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productDetailResponse
                                                    .data!
                                                    .product!
                                                    .skuName ??
                                                "",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: productDetailResponse
                                                          .data!
                                                          .product!
                                                          .variants![varientIndex]
                                                          .discountPrice
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: productDetailResponse
                                                          .data!
                                                          .product!
                                                          .variants![varientIndex]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 14,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            spacing: 20,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    showProductBottomSheet(
                                                      context,
                                                      productDetailResponse
                                                              .data!
                                                              .product!
                                                              .skuName ??
                                                          "",
                                                      false,
                                                      0,
                                                      productDetailResponse
                                                              .data!
                                                              .product!
                                                              .variants ??
                                                          [],
                                                      context
                                                          .read<
                                                            ProductDetailBloc
                                                          >(),
                                                    );
                                                  },
                                                  child: Container(
                                                    // height: 35,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 4,
                                                          vertical: 8,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(
                                                          0xFFAAAAAA,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      spacing: 10,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(),
                                                        Expanded(
                                                          child: Text(
                                                            selectedVariant
                                                                    .label ??
                                                                productDetailResponse
                                                                    .data!
                                                                    .product!
                                                                    .variants!
                                                                    .firstWhere(
                                                                      (
                                                                        variant,
                                                                      ) =>
                                                                          (variant.userCartQuantity ??
                                                                              0) >
                                                                          0,
                                                                      orElse: () => productDetailResponse
                                                                          .data!
                                                                          .product!
                                                                          .variants![0],
                                                                    )
                                                                    .label ??
                                                                "",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              //fontSize: 10,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Find the first variant with cartQuantity > 0 or fallback to the first variant

                                              // Display the buttons dynamically
                                              selectedVariant
                                                          .userCartQuantity ==
                                                      0
                                                  ? SizedBox(
                                                      width: 130,
                                                      height: 35,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              whitecolor,
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              color: appColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                ProductDetailBloc
                                                              >()
                                                              .add(
                                                                AddButtonClikedEvent(
                                                                  type:
                                                                      "screen",
                                                                  index:
                                                                      varientIndex,
                                                                  similarIndex:
                                                                      0,
                                                                  isButtonPressed:
                                                                      true,
                                                                ),
                                                              );
                                                        },
                                                        child: Text(
                                                          "Add",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                color: appColor,
                                                                fontSize: 14,
                                                              ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 130,
                                                      height: 35,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 1,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                        border: Border.all(
                                                          color: appColor,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                      ProductDetailBloc
                                                                    >()
                                                                    .add(
                                                                      RemoveItemButtonClikedEvent(
                                                                        type:
                                                                            "screen",
                                                                        index:
                                                                            varientIndex,
                                                                        similarIndex:
                                                                            0,
                                                                        isButtonPressed:
                                                                            true,
                                                                      ),
                                                                    );
                                                              },
                                                              child: SizedBox(
                                                                height: 30,
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                            child: Center(
                                                              child: Text(
                                                                selectedVariant
                                                                    .userCartQuantity
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.poppins(
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
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                      ProductDetailBloc
                                                                    >()
                                                                    .add(
                                                                      AddButtonClikedEvent(
                                                                        type:
                                                                            "screen",
                                                                        index:
                                                                            varientIndex,
                                                                        similarIndex:
                                                                            0,
                                                                        isButtonPressed:
                                                                            true,
                                                                      ),
                                                                    );
                                                              },
                                                              child: SizedBox(
                                                                height: 30,
                                                                child: Center(
                                                                  child: const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              // productDetailResponse
                                              //             .data!
                                              //             .product!
                                              //             .variants![varientIndex]
                                              //             .userCartQuantity ==
                                              //         0
                                              //     ? SizedBox(
                                              //         width: 130,
                                              //         height: 35,
                                              //         child: ElevatedButton(
                                              //           style: ElevatedButton
                                              //               .styleFrom(
                                              //             backgroundColor:
                                              //                 whitecolor,
                                              //             shape:
                                              //                 RoundedRectangleBorder(
                                              //               side: BorderSide(
                                              //                   color: appColor),
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(20),
                                              //             ),
                                              //           ),
                                              //           onPressed: () {
                                              //             context
                                              //                 .read<
                                              //                     ProductDetailBloc>()
                                              //                 .add(AddButtonClikedEvent(
                                              //                     type: "screen",
                                              //                     index:
                                              //                         varientIndex,
                                              //                     similarIndex: 0,
                                              //                     isButtonPressed:
                                              //                         true));
                                              //           },
                                              //           child: Text(
                                              //             "Add",
                                              //             style:
                                              //                 GoogleFonts.poppins(
                                              //               color: appColor,
                                              //               fontSize: 14,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       )
                                              //     : Container(
                                              //         width: 130,
                                              //         height: 35,
                                              //         padding: const EdgeInsets
                                              //             .symmetric(vertical: 1),
                                              //         decoration: BoxDecoration(
                                              //           color: productDetailResponse
                                              //                       .data!
                                              //                       .product!
                                              //                       .variants![
                                              //                           varientIndex]
                                              //                       .userCartQuantity ==
                                              //                   0
                                              //               ? whitecolor
                                              //               : appColor,
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   20),
                                              //           border: Border.all(
                                              //               color: appColor),
                                              //         ),
                                              //         child: Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .center,
                                              //           children: [
                                              //             Expanded(
                                              //               child: InkWell(
                                              //                 onTap: () {
                                              //                   context
                                              //                       .read<
                                              //                           ProductDetailBloc>()
                                              //                       .add(RemoveItemButtonClikedEvent(
                                              //                           type:
                                              //                               "screen",
                                              //                           index:
                                              //                               varientIndex,
                                              //                           similarIndex:
                                              //                               0,
                                              //                           isButtonPressed:
                                              //                               true));
                                              //                   // context.read<ProductBloc>().add(
                                              //                   //     ChangeVarientItemEvent(
                                              //                   //         productIndex:
                                              //                   //             productIndex,
                                              //                   //         varientIndex: i));
                                              //                   // context.read<ProductBloc>().add(
                                              //                   //     RemoveItemButtonClikedEvent(
                                              //                   //         type: "dialog",
                                              //                   //         index: productIndex,
                                              //                   //         isButtonPressed:
                                              //                   //             true));
                                              //                 },
                                              //                 child: SizedBox(
                                              //                   height: 30,
                                              //                   child: const Icon(
                                              //                       Icons.remove,
                                              //                       color: Colors
                                              //                           .white,
                                              //                       size: 16),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //             Container(
                                              //               height: 35,
                                              //               width: 35,
                                              //               decoration:
                                              //                   BoxDecoration(
                                              //                 color: Colors.white,
                                              //               ),
                                              //               child: Center(
                                              //                 child: Text(
                                              //                   productDetailResponse
                                              //                       .data!
                                              //                       .product!
                                              //                       .variants![
                                              //                           varientIndex]
                                              //                       .userCartQuantity
                                              //                       .toString(),
                                              //                   textAlign:
                                              //                       TextAlign
                                              //                           .center,
                                              //                   style: GoogleFonts
                                              //                       .poppins(
                                              //                     color: const Color(
                                              //                         0xFF326A32),
                                              //                     fontSize: 14,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w500,
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //             Expanded(
                                              //               child: InkWell(
                                              //                 onTap: () {
                                              //                   context
                                              //                       .read<
                                              //                           ProductDetailBloc>()
                                              //                       .add(AddButtonClikedEvent(
                                              //                           type:
                                              //                               "screen",
                                              //                           index:
                                              //                               varientIndex,
                                              //                           similarIndex:
                                              //                               0,
                                              //                           isButtonPressed:
                                              //                               true));
                                              //                 },
                                              //                 child: SizedBox(
                                              //                   height: 30,
                                              //                   child: Center(
                                              //                     child: const Icon(
                                              //                         Icons.add,
                                              //                         color: Colors
                                              //                             .white,
                                              //                         size: 16),
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ExpansionTile(
                                  backgroundColor: whitecolor,
                                  collapsedBackgroundColor: whitecolor,
                                  shape: Border.all(color: whitecolor),
                                  iconColor: appColor,
                                  collapsedIconColor: appColor,
                                  title: Text(
                                    'Product Information',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  children: <Widget>[
                                    Column(
                                      spacing: 10,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "     •     ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'About - ${productDetailResponse.data!.product!.description!.about}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "     •     ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Health Benefits - ${productDetailResponse.data!.product!.description!.healthBenefits}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "     •     ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Nutrition - ${productDetailResponse.data!.product!.description!.nutrition}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "     •     ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Origin of Place - ${productDetailResponse.data!.product!.description!.origin}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (similarProductResponse.data != null)
                                Text(
                                  "Similar Products",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayMedium,
                                ),
                              if (similarProductResponse.data != null)
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    double screenWidth = constraints.maxWidth;
                                    double itemWidth =
                                        (screenWidth - (22 * 2)) /
                                        3; // Adjust for crossAxisSpacing
                                    double itemHeight =
                                        itemWidth *
                                        1.2; // Adjust height dynamically
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          for (
                                            int i = 0;
                                            i <
                                                similarProductResponse
                                                    .data!
                                                    .length;
                                            i++
                                          )
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<ProductDetailBloc>()
                                                    .add(
                                                      UpdateSimilarIndexEvent(
                                                        index: i,
                                                        similarIndex: i,
                                                      ),
                                                    );
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ProductDetailsScreen(
                                                        productId:
                                                            similarProductResponse
                                                                .data![i]
                                                                .similarProductId ??
                                                            "",
                                                        screenType: "",
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 240,
                                                width: itemHeight > 150
                                                    ? MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          2.4
                                                    : MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          2,
                                                decoration: BoxDecoration(
                                                  color: whitecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  top: 12.0,
                                                                ),
                                                            child: ImageNetwork(
                                                              url:
                                                                  similarProductResponse
                                                                      .data![i]
                                                                      .variants![0]
                                                                      .imageUrl ??
                                                                  "",
                                                              height: 100,
                                                              //width: double.infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4,
                                                                ),
                                                            decoration: const BoxDecoration(
                                                              color: Color(
                                                                0xFF034703,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          20,
                                                                        ),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                          20,
                                                                        ),
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              similarProductResponse
                                                                      .data![i]
                                                                      .variants![0]
                                                                      .offer ??
                                                                  "",
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              10,
                                                            ),
                                                        child: Column(
                                                          //  spacing: 8,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              similarProductResponse
                                                                      .data![i]
                                                                      .skuName ??
                                                                  "",
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(height: 6),
                                                            InkWell(
                                                              onTap: () {
                                                                // debugPrint(
                                                                //     selectedProductIndexes
                                                                //         .toString());
                                                                // showProductBottomSheet(
                                                                //     context,
                                                                //     similarProductResponse
                                                                //             .data![
                                                                //                 i]
                                                                //             .skuName ??
                                                                //         "",
                                                                //     true,
                                                                //     i,
                                                                //     similarProductResponse
                                                                //             .data![
                                                                //                 i]
                                                                //             .variants ??
                                                                //         [],
                                                                //     context.read<
                                                                //         ProductDetailBloc>());
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: const Color(
                                                                      0xFFE0ECE0,
                                                                    ),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        4,
                                                                      ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        // similarProductResponse
                                                                        //         .data![
                                                                        //             i]
                                                                        //         .variants![
                                                                        //             similarvarientIndex]
                                                                        //         .label ??
                                                                        //     "",
                                                                        similarProductResponse.data![i].variants!
                                                                                .firstWhere(
                                                                                  (
                                                                                    variant,
                                                                                  ) =>
                                                                                      (variant.cartQuantity ??
                                                                                          0) >
                                                                                      0,
                                                                                  orElse: () => similarProductResponse.data![i].variants![0],
                                                                                )
                                                                                .label ??
                                                                            "",
                                                                        // selectedsimilarVariant
                                                                        //         .label ??
                                                                        //     similarProductResponse
                                                                        //         .data![
                                                                        //             i]
                                                                        //         .variants!
                                                                        //         .firstWhere(
                                                                        //           (variant) => (variant.userCartQuantity ?? 0) > 0,
                                                                        //           orElse: () => similarProductResponse.data![i].variants![0],
                                                                        //         )
                                                                        //         .label ??
                                                                        //     "",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // Icon(
                                                                    //     Icons
                                                                    //         .keyboard_arrow_down_rounded,
                                                                    //     size: 15),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 6),
                                                            Row(
                                                              spacing: 10,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    RichText(
                                                                      text: TextSpan(
                                                                        text:
                                                                            '₹ ',
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        children:
                                                                            <
                                                                              TextSpan
                                                                            >[
                                                                              TextSpan(
                                                                                text: similarProductResponse.data![i].variants![0].discountPrice.toString(),
                                                                                style: const TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Text(
                                                                      similarProductResponse
                                                                          .data![i]
                                                                          .variants![0]
                                                                          .price
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                          0xFF777777,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                similarProductResponse
                                                                            .data![i]
                                                                            .variants!
                                                                            .firstWhere(
                                                                              (
                                                                                variant,
                                                                              ) =>
                                                                                  (variant.cartQuantity ??
                                                                                      0) >
                                                                                  0,
                                                                              orElse: () => similarProductResponse.data![i].variants![0],
                                                                            )
                                                                            .cartQuantity ==
                                                                        0
                                                                    // similarProductResponse
                                                                    //             .data![i]
                                                                    //             .variants![
                                                                    //                 similarvarientIndex]
                                                                    //             .userCartQuantity ==
                                                                    //         0
                                                                    // selectedsimilarVariant
                                                                    //             .userCartQuantity ==
                                                                    //         0
                                                                    ? Expanded(
                                                                        child: InkWell(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                  ProductDetailBloc
                                                                                >()
                                                                                .add(
                                                                                  AddButtonClikedEvent(
                                                                                    type: "similar",
                                                                                    index: similarIndex,
                                                                                    similarIndex: i,
                                                                                    isButtonPressed: true,
                                                                                  ),
                                                                                );
                                                                            // context.read<HomeBloc>().add(AddButtonClikedEvent(
                                                                            //     response:
                                                                            //         nutsDriedFruitsResponse,
                                                                            //     type:
                                                                            //         "screen",
                                                                            //     index:
                                                                            //         i,
                                                                            //     isButtonPressed:
                                                                            //         true));
                                                                          },
                                                                          child: Container(
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                color: appColor,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20,
                                                                              ),
                                                                            ),
                                                                            child: Center(
                                                                              child: Text(
                                                                                'Add',
                                                                                style: TextStyle(
                                                                                  color: appColor,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Expanded(
                                                                        child: Container(
                                                                          //width: 130,
                                                                          height:
                                                                              35,
                                                                          padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1,
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                similarProductResponse.data![i].variants!
                                                                                        .firstWhere(
                                                                                          (
                                                                                            variant,
                                                                                          ) =>
                                                                                              (variant.cartQuantity ??
                                                                                                  0) >
                                                                                              0,
                                                                                          orElse: () => similarProductResponse.data![i].variants![0],
                                                                                        )
                                                                                        .cartQuantity ==
                                                                                    0
                                                                                ? whitecolor
                                                                                : appColor,
                                                                            borderRadius: BorderRadius.circular(
                                                                              20,
                                                                            ),
                                                                            border: Border.all(
                                                                              color: appColor,
                                                                            ),
                                                                          ),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          ProductDetailBloc
                                                                                        >()
                                                                                        .add(
                                                                                          RemoveItemButtonClikedEvent(
                                                                                            type: "similar",
                                                                                            index: similarIndex,
                                                                                            similarIndex: i,
                                                                                            isButtonPressed: true,
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
                                                                                height: 35,
                                                                                width: 20,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    // similarProductResponse.data![i].variants![similarIndex].userCartQuantity.toString(),
                                                                                    similarProductResponse.data![i].variants!
                                                                                        .firstWhere(
                                                                                          (
                                                                                            variant,
                                                                                          ) =>
                                                                                              (variant.cartQuantity ??
                                                                                                  0) >
                                                                                              0,
                                                                                          orElse: () => similarProductResponse.data![i].variants![0],
                                                                                        )
                                                                                        .cartQuantity
                                                                                        .toString(),
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.poppins(
                                                                                      color: appColor,
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    context
                                                                                        .read<
                                                                                          ProductDetailBloc
                                                                                        >()
                                                                                        .add(
                                                                                          AddButtonClikedEvent(
                                                                                            type: "similar",
                                                                                            index: similarIndex,
                                                                                            similarIndex: i,
                                                                                            isButtonPressed: true,
                                                                                          ),
                                                                                        );
                                                                                    // context.read<ProductDetailBloc>().add(AddButtonClikedEvent(type: "similar", index: similarIndex, similarIndex: similarvarientIndex, isButtonPressed: true));
                                                                                    //context.read<ProductDetailBloc>().add(AddButtonClikedEvent(type: "screen", index: varientIndex, isButtonPressed: true));
                                                                                  },
                                                                                  child: SizedBox(
                                                                                    height: 30,
                                                                                    child: Center(
                                                                                      child: const Icon(
                                                                                        Icons.add,
                                                                                        color: Colors.white,
                                                                                        size: 16,
                                                                                      ),
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          )
                        : Column(
                            children: [
                              SingleChildScrollView(
                                padding: EdgeInsets.all(16),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image
                                      Container(
                                        height: 200,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),

                                      SizedBox(height: 16),
                                      // Title
                                      Container(
                                        height: 20,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 8),
                                      // Price
                                      Container(
                                        height: 20,
                                        width: 100,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 16),
                                      // Dropdown & Button
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 100,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 16),
                                          Container(
                                            height: 40,
                                            width: 80,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24),
                                      // Product Info dropdown placeholder
                                      Container(
                                        height: 20,
                                        width: 200,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 24),
                                      // Similar Products Title
                                      Container(
                                        height: 20,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 16),
                                      // Horizontal list of similar products
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            3,
                                            (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                right: 16,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    height: 16,
                                                    width: 80,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    height: 16,
                                                    width: 50,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    height: 30,
                                                    width: 60,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
