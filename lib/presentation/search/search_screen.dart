import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/home/search_response_model.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_screen.dart';
import 'package:sodakkuapp/presentation/search/search_bloc.dart';
import 'package:sodakkuapp/presentation/search/search_event.dart';
import 'package:sodakkuapp/presentation/search/search_state.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';

class SearchScreen extends StatelessWidget {
  final String? searchTitle;
  const SearchScreen({required this.searchTitle, super.key});

  static TextEditingController searchController = TextEditingController();
  static ValueNotifier<String> valueNotifier = ValueNotifier('a');
  static SearchResponse searchResponse = SearchResponse();
  static int variantindex = 0;
  static String nodata = "";

  void showProductBottomSheet(
    BuildContext context,
    String name,
    int productIndex,
    SearchBloc searchBloc,
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
          value: searchBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            // ✅ Now BlocBuilder will work because ProductBloc is provided
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchResponse
                                  .data![productIndex]
                                  .variants!
                                  .length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    context.read<SearchBloc>().add(
                                      ChangeVarientItemEvent(
                                        productIndex: productIndex,
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
                                                searchResponse
                                                        .data![productIndex]
                                                        .variants![i]
                                                        .label ??
                                                    "",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                              ),
                                              Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '₹ ',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: searchResponse
                                                              .data![productIndex]
                                                              .variants![i]
                                                              .discountPrice
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: '₹ ',
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: searchResponse
                                                              .data![productIndex]
                                                              .variants![i]
                                                              .price
                                                              .toString(),
                                                          style: const TextStyle(
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
                                        searchResponse
                                                    .data![productIndex]
                                                    .variants![i]
                                                    .cartQuantity ==
                                                0
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {});
                                                  context
                                                      .read<SearchBloc>()
                                                      .add(
                                                        ChangeVarientItemEvent(
                                                          productIndex:
                                                              productIndex,
                                                          varientIndex: i,
                                                        ),
                                                      );
                                                  context
                                                      .read<SearchBloc>()
                                                      .add(
                                                        AddButtonClickedEvent(
                                                          type: "dialog",
                                                          index: productIndex,
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
                                                        searchResponse
                                                                .data![productIndex]
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            color: appColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 130,
                                                height: 30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 1,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      searchResponse
                                                              .data![productIndex]
                                                              .variants![i]
                                                              .cartQuantity ==
                                                          0
                                                      ? whitecolor
                                                      : appColor,
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
                                                          // context.read<ProductBloc>().add(
                                                          //     RemoveItemButtonClikedEvent(
                                                          //         type: "dialog",
                                                          //         index: i,
                                                          //         isButtonPressed:
                                                          //             true));

                                                          context
                                                              .read<
                                                                SearchBloc
                                                              >()
                                                              .add(
                                                                ChangeVarientItemEvent(
                                                                  productIndex:
                                                                      productIndex,
                                                                  varientIndex:
                                                                      i,
                                                                ),
                                                              );
                                                          context
                                                              .read<
                                                                SearchBloc
                                                              >()
                                                              .add(
                                                                RemoveButtonClickedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index:
                                                                      productIndex,
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
                                                      // margin:
                                                      //     const EdgeInsets.symmetric(
                                                      //         horizontal: 16),
                                                      width: 37,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                        i == variantindex
                                                            ? searchResponse
                                                                  .data![productIndex]
                                                                  .variants![i]
                                                                  .cartQuantity
                                                                  .toString()
                                                            : searchResponse
                                                                  .data![productIndex]
                                                                  .variants![i]
                                                                  .cartQuantity
                                                                  .toString(),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                SearchBloc
                                                              >()
                                                              .add(
                                                                ChangeVarientItemEvent(
                                                                  productIndex:
                                                                      productIndex,
                                                                  varientIndex:
                                                                      i,
                                                                ),
                                                              );
                                                          context
                                                              .read<
                                                                SearchBloc
                                                              >()
                                                              .add(
                                                                AddButtonClickedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index:
                                                                      productIndex,
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

                            // cartCount == 0
                            //     ? SizedBox()
                            //     : Container(
                            //         height: 56,
                            //         width: double.infinity,
                            //         decoration: BoxDecoration(
                            //           color: appColor,
                            //           borderRadius: BorderRadius.circular(20),
                            //         ),
                            //         child: Center(
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 20, right: 20),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Text(
                            //                       "$cartCount Item",
                            //                       style: GoogleFonts.poppins(
                            //                         fontSize: 16,
                            //                         color: whitecolor,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                     ),
                            //                     Text(
                            //                       " | ",
                            //                       style: GoogleFonts.poppins(
                            //                         fontSize: 16,
                            //                         color: whitecolor,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                     ),
                            //                     RichText(
                            //                       text: TextSpan(
                            //                         text: '₹',
                            //                         style: TextStyle(
                            //                           fontSize: 16,
                            //                           color: whitecolor,
                            //                           fontWeight: FontWeight.bold,
                            //                         ),
                            //                         children: <TextSpan>[
                            //                           TextSpan(
                            //                             text: totalAmount
                            //                                 .toString(),
                            //                             style: TextStyle(
                            //                               fontFamily: '`Poppins`',
                            //                               fontSize: 16,
                            //                               color: whitecolor,
                            //                               fontWeight:
                            //                                   FontWeight.bold,
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 InkWell(
                            //                   onTap: () {
                            //                     Navigator.pop(context);
                            //                     // Navigator.pushNamed(context, '/cart');
                            //                     Navigator.push(context,
                            //                         MaterialPageRoute(
                            //                       builder: (context) {
                            //                         return CartScreen(
                            //                           fromScreen: 'productlist',
                            //                         );
                            //                       },
                            //                     ));
                            //                   },
                            //                   child: Row(
                            //                     spacing: 10,
                            //                     children: [
                            //                       Image.asset(viewCartImage),
                            //                       Text(
                            //                         "View Cart",
                            //                         style: GoogleFonts.poppins(
                            //                           fontSize: 16,
                            //                           color: whitecolor,
                            //                           fontWeight: FontWeight.bold,
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            const SizedBox(height: 10),
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
    searchController.addListener(() {
      valueNotifier.value = searchController.text;
    });
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccessState) {
            searchResponse = state.searchResults;
          } else if (state is CloseState) {
            searchController.clear();
            searchResponse = SearchResponse();
          } else if (state is AddButtonClickedState) {
            if (state.type == "screen") {
              searchResponse.data![state.index].variants![0].cartQuantity =
                  searchResponse.data![state.index].variants![0].cartQuantity! +
                  1;
              context.read<SearchBloc>().add(
                ItemAddToCartApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  quantity: 1,
                  variantLabel: searchResponse
                      .data![state.index]
                      .variants![0]
                      .label
                      .toString(),
                  imageUrl: searchResponse
                      .data![state.index]
                      .variants![0]
                      .imageUrl
                      .toString(),
                  price:
                      searchResponse.data![state.index].variants![0].price ?? 0,
                  discountPrice:
                      searchResponse
                          .data![state.index]
                          .variants![0]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else {
              searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity =
                  searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity! +
                  1;

              context.read<SearchBloc>().add(
                ItemAddToCartApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  quantity: 1,
                  variantLabel: searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .label
                      .toString(),
                  imageUrl: searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .imageUrl
                      .toString(),
                  price:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .price ??
                      0,
                  discountPrice:
                      searchResponse
                          .data![state.index]
                          .variants![variantindex]
                          .discountPrice ??
                      0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            }
          } else if (state is AddedItemToCartState) {
            // context.read<ProductBloc>().add(CartLengthEvent(userId: userId));
            // context.read<SearchBloc>().add(ProductStyleEvent(
            //     mobilNo: phoneNumber,
            //     userId: userId,
            //     isMainCategory: isMainCategory,
            //     mainCatId: mainCatId,
            //     isSubCategory: true,
            //     subCatId: subCatList[isSelected].id ?? "",
            //     page: page));
          } else if (state is RemoveButtonClickedState) {
            if (state.type == "screen") {
              searchResponse.data![state.index].variants![0].cartQuantity =
                  searchResponse.data![state.index].variants![0].cartQuantity! -
                  1;

              context.read<SearchBloc>().add(
                ItemRemoveFromApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  variantLabel: searchResponse
                      .data![state.index]
                      .variants![0]
                      .label
                      .toString(),
                  quantity: 1,
                  handlingCharges: 0,
                  deliveryTip: 0,
                ),
              );
            } else {
              searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity =
                  searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .cartQuantity! -
                  1;
              context.read<SearchBloc>().add(
                ItemRemoveFromApiEvent(
                  userId: userId,
                  productId: searchResponse.data![state.index].id ?? "",
                  variantLabel: searchResponse
                      .data![state.index]
                      .variants![variantindex]
                      .label
                      .toString(),
                  quantity: 1,
                  handlingCharges: 0,
                  deliveryTip: 0,
                ),
              );
            }
          } else if (state is ItemRemovedCartState) {
            // context.read<ProductBloc>().add(CartLengthEvent(userId: userId));
            // context.read<ProductBloc>().add(ProductStyleEvent(
            //     mobilNo: phoneNumber,
            //     userId: userId,
            //     isMainCategory: isMainCategory,
            //     mainCatId: mainCatId,
            //     isSubCategory: true,
            //     subCatId: subCatList[isSelected].id ?? "",
            //     page: page));
          } else if (state is VarientChangedState) {
            // productIndex = state.productIndex;
            variantindex = state.varientIndex;
            // selectedProductIndexes = state.productIndex;

            // debugPrint(
            //     '${productStyleResponse.data![productIndex].variants![productVarientIndex].cartQuantity} - ${productStyleResponse.data![productIndex].variants![productVarientIndex].label}');
          } else if (state is SearchErrorState) {
            searchResponse = SearchResponse();
            nodata = "Could not find any products for";
          }
        },
        builder: (context, state) {
          if (state is SearchInitialState) {
            searchController.clear();
            searchResponse = SearchResponse();
            // context.read<SearchBloc>().add(SearchApiEvent(
            //       searchText: searchController.text,
            //     ));
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is SearchLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black54),
                        ),
                        //  width: size.width,
                        height: 50,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(backsvg),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: appColor,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: (value) {
                                  context.read<SearchBloc>().add(
                                    SearchApiEvent(
                                      searchText: searchController.text,
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: 'Search For "$searchTitle"',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  context.read<SearchBloc>().add(
                                    SearchApiEvent(searchText: value),
                                  );
                                },
                              ),
                            ),
                            valueNotifier.value.length > 10
                                ? GestureDetector(
                                    onTap: () {
                                      context.read<SearchBloc>().add(
                                        ClickCloseButtonEvent(),
                                      );
                                    },
                                    child: SvgPicture.asset(closesvg),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      searchResponse.data == null
                          ? Visibility(
                              visible: searchController.text.isNotEmpty,
                              child: Row(
                                children: [
                                  Text(
                                    nodata,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' "${searchController.text}"',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: searchResponse.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProductDetailsScreen(
                                              productId:
                                                  searchResponse
                                                      .data![index]
                                                      .id ??
                                                  "",
                                              screenType: "back",
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    leading: ImageNetwork(
                                      url:
                                          searchResponse
                                              .data![index]
                                              .variants![0]
                                              .imageUrl ??
                                          "",
                                      height: 30,
                                      width: 30,
                                    ),
                                    title: Text(
                                      searchResponse.data![index].skuName ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      /* Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double screenWidth = constraints.maxWidth;
                                    double itemWidth = screenWidth / 2 -
                                        10; // Adjust for spacing
                                    double itemHeight = itemWidth *
                                        1.8; // Adjust height dynamically
                                    return GridView.builder(
                                      //    controller: _scrollController,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: itemWidth /
                                            itemHeight, // Dynamic aspect ratio
                                      ),
                                      itemCount: searchResponse.data!.length,
                                      itemBuilder: (context, index) {
                                        if (searchResponse.data!.isEmpty) {
                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: appColor,
                                            )),
                                          );
                                        } else {
                                          return Container(
                                            width: itemWidth,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              spacing: 3,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return ProductDetailsScreen(
                                                              productId:
                                                                  searchResponse
                                                                          .data![
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                        },
                                                      )).then(
                                                        (value) {
                                                          // Scroll to the top
                                                          // _scrollController.animateTo(
                                                          //   0.0,
                                                          //   duration: const Duration(
                                                          //       milliseconds: 300),
                                                          //   curve: Curves.easeInOut,
                                                          // );
                                                          // if (!context.mounted) return;
                                                          // selectedIndexes = 0;
                                                          // ProductBloc.productList = [];
                                                          // page = 1;
                                                          // context
                                                          //     .read<ProductBloc>()
                                                          //     .add(ProductStyleEvent(
                                                          //         mobilNo: phoneNumber,
                                                          //         userId: userId,
                                                          //         isMainCategory:
                                                          //             isMainCategory,
                                                          //         mainCatId: mainCatId,
                                                          //         isSubCategory: true,
                                                          //         subCatId: subCatList[
                                                          //                     isSelected]
                                                          //                 .id ??
                                                          //             "",
                                                          //         page: page));
                                                          // context
                                                          //     .read<ProductBloc>()
                                                          //     .add(CartLengthEvent(
                                                          //         userId: userId));
                                                        },
                                                      );
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 12.0),
                                                            child:
                                                                 ImageNetwork(url:
                                                              searchResponse
                                                                      .data![
                                                                          index]
                                                                      .variants![
                                                                          0]
                                                                      .imageUrl ??
                                                                  "",
                                                              fit: BoxFit
                                                                  .contain,
                                                              width: itemWidth,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF034703),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              searchResponse
                                                                      .data![
                                                                          index]
                                                                      .variants![
                                                                          0]
                                                                      .offer ??
                                                                  "",
                                                              style:
                                                                  const TextStyle(
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
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        searchResponse
                                                                .data![index]
                                                                .skuName ??
                                                            "",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 6),
                                                      InkWell(
                                                        onTap: () {
                                                          debugPrint(
                                                              searchResponse
                                                                  .toString());
                                                          showProductBottomSheet(
                                                              context,
                                                              searchResponse
                                                                      .data![
                                                                          index]
                                                                      .skuName ??
                                                                  "",
                                                              index,
                                                              context.read<
                                                                  SearchBloc>());
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xFFE0ECE0)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                    searchResponse
                                                                            .data![
                                                                                index]
                                                                            .variants![
                                                                                0]
                                                                            .label ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                              Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  size: 15),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: '₹ ',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      '${searchResponse.data![index].variants![0].discountPrice ?? ""}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          Text(
                                                            searchResponse
                                                                .data![index]
                                                                .variants![0]
                                                                .price
                                                                .toString(),
                                                            style: const TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFF777777)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 6),
                                                      searchResponse
                                                                  .data![index]
                                                                  .variants![0]
                                                                  .cartQuantity ==
                                                              0
                                                          ? InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                        SearchBloc>()
                                                                    .add(AddButtonClickedEvent(
                                                                        type:
                                                                            "screen",
                                                                        index:
                                                                            index));
                                                              },
                                                              child: Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          1),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          whitecolor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              appColor)),
                                                                  height: 27,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "Add",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              appColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            )
                                                          : Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          1),
                                                              decoration: BoxDecoration(
                                                                  color: const appColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              appColor)),
                                                              height: 27,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        context.read<SearchBloc>().add(RemoveButtonClickedEvent(
                                                                            type:
                                                                                "screen",
                                                                            index:
                                                                                index));
                                                                      },
                                                                      child: const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color: Colors
                                                                              .white,
                                                                          size:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // margin:
                                                                    //     const EdgeInsets
                                                                    //         .symmetric(
                                                                    //         horizontal:
                                                                    //             16),
                                                                    //  padding: const EdgeInsets.symmetric(vertical: 2),
                                                                    width: 37,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      //  borderRadius: BorderRadius.circular(4),
                                                                    ),
                                                                    child: Text(
                                                                      searchResponse
                                                                          .data![
                                                                              index]
                                                                          .variants![
                                                                              0]
                                                                          .cartQuantity
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: const Color(
                                                                            0xFF326A32),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        context.read<SearchBloc>().add(AddButtonClickedEvent(
                                                                            type:
                                                                                "screen",
                                                                            index:
                                                                                index));
                                                                      },
                                                                      child: const Icon(
                                                                          Icons
                                                                              .add,
                                                                          color: Colors
                                                                              .white,
                                                                          size:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ), */
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
