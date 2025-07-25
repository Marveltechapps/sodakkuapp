import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/product_detail_model.dart';
import 'package:sodakkuapp/model/category/product_style_model.dart';
import 'package:sodakkuapp/model/category/sub_category_model.dart' as sub;
import 'package:sodakkuapp/presentation/cart/cart_screen.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_screen.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_bloc.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_event.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_state.dart';
import 'package:sodakkuapp/presentation/search/search_screen.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

// ignore: must_be_immutable
class ProductListMenuScreen extends StatefulWidget {
  String title;
  String id;
  bool isMainCategory;
  String mainCatId;
  bool isCategory;
  String catId;
  ProductListMenuScreen({
    super.key,
    required this.title,
    required this.id,
    required this.isMainCategory,
    required this.mainCatId,
    required this.isCategory,
    required this.catId,
  });

  @override
  State<ProductListMenuScreen> createState() => _ProductListMenuScreenState();
}

class _ProductListMenuScreenState extends State<ProductListMenuScreen> {
  static int page = 1;

  // ScrollController scrollController = ScrollController();

  static int isSelected = 0;
  static List<int> itemCount = [];
  static bool addButtonClicked = false;
  static String errorMsg = "";
  static int variantindex = 0;
  static ProductList product = ProductList();

  static int productIndex = 0;
  static int productVarientIndex = 0;
  static int selectedProductIndexes = 0;
  static int cartCount = 0;
  static int totalAmount = 0;
  static String subCategoryId = "";
  static ProductDetailResponse productDetailResponse = ProductDetailResponse();
  static bool isLoading = false;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _widgetKey2 = GlobalKey();
  int selectedIndexes = 0;

  List<sub.Datum> subCatList = [];

  ProductStyleResponse productStyleResponse = ProductStyleResponse();

  // Flag to track API call status
  CartResponse cartResponse = CartResponse();

  // void showProductBottomSheet(BuildContext context, String name,
  void showProductBottomSheet(
    BuildContext context,
    String name,
    int productIndex,
    ProductListBloc productBloc,
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
          value: productBloc,
          child: StatefulBuilder(
            builder: (context, setState) {
              return BlocBuilder<ProductListBloc, ProductListState>(
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
                              itemCount: productStyleResponse
                                  .data![productIndex]
                                  .variants!
                                  .length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    context.read<ProductListBloc>().add(
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
                                        color: appColor.withAlpha(120),
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
                                                productStyleResponse
                                                        .data![productIndex]
                                                        .variants![i]
                                                        .label ??
                                                    "",
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
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: productStyleResponse
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
                                                          text: productStyleResponse
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
                                        productStyleResponse
                                                    .data![productIndex]
                                                    .variants![i]
                                                    .userCartQuantity ==
                                                0
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    productVarientIndex = i;
                                                  });
                                                  context
                                                      .read<ProductListBloc>()
                                                      .add(
                                                        ChangeVarientItemEvent(
                                                          productIndex:
                                                              productIndex,
                                                          varientIndex: i,
                                                        ),
                                                      );
                                                  context
                                                      .read<ProductListBloc>()
                                                      .add(
                                                        AddButtonClikedEvent(
                                                          type: "screen",
                                                          index: productIndex,
                                                          isButtonPressed: true,
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
                                                        productStyleResponse
                                                                .data![productIndex]
                                                                .variants![i]
                                                                .userCartQuantity ==
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
                                                      productStyleResponse
                                                              .data![productIndex]
                                                              .variants![i]
                                                              .userCartQuantity ==
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
                                                          // context.read<ProductListBloc>().add(
                                                          //     RemoveItemButtonClikedEvent(
                                                          //         type: "dialog",
                                                          //         index: i,
                                                          //         isButtonPressed:
                                                          //             true));

                                                          context
                                                              .read<
                                                                ProductListBloc
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
                                                                ProductListBloc
                                                              >()
                                                              .add(
                                                                RemoveItemButtonClikedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index:
                                                                      productIndex,
                                                                  isButtonPressed:
                                                                      true,
                                                                  variantIndex:
                                                                      productVarientIndex,
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
                                                            ? productStyleResponse
                                                                  .data![productIndex]
                                                                  .variants![i]
                                                                  .userCartQuantity
                                                                  .toString()
                                                            : productStyleResponse
                                                                  .data![productIndex]
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
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                ProductListBloc
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
                                                                ProductListBloc
                                                              >()
                                                              .add(
                                                                AddButtonClikedEvent(
                                                                  type:
                                                                      "dialog",
                                                                  index:
                                                                      productIndex,
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
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${cartCount} Item",
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
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                // Navigator.pushNamed(context, '/cart');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return CartScreen(
                                                        fromScreen:
                                                            'productlist',
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

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (!(prefs.getBool('firstLaunchTooltip') ?? false)) {
        ShowCaseWidget.of(context).startShowCase([_widgetKey2, _widgetKey]);
        prefs.setBool('firstLaunchTooltip', true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc(),
      child: BlocConsumer<ProductListBloc, ProductListState>(
        listener: (context, state) {
          if (state is OnScrollSuccessState) {
            //page++;
            //debugPrint(page.toString());
            debugPrint(state.page.toString());
            page = state.page;
          } else if (state is ProductSelectedState) {
            productIndex = 0;
            productVarientIndex = 0;
            selectedProductIndexes = 0;
            isSelected = state.index;
            title = state.name;
            page = 1;
            ProductListBloc.productList = [];
            context.read<ProductListBloc>().add(
              ProductStyleEvent(
                mobilNo: phoneNumber,
                userId: userId,
                isMainCategory: widget.isMainCategory,
                mainCatId: widget.mainCatId,
                isSubCategory: true,
                subCatId: subCatList[isSelected].id ?? "",
                page: page,
              ),
            );
          } else if (state is CartCountSuccessState) {
            cartResponse = state.cartResponse;
            cartCount = 0;
            if (state.cartResponse.items != null) {
              for (var i = 0; i < state.cartResponse.items!.length; i++) {
                cartCount =
                    cartCount + (state.cartResponse.items![i].quantity ?? 0);
              }
            }
            totalAmount = state.cartResponse.billSummary!.itemTotal ?? 0;
          } else if (state is AddButtonClickedState) {
            addButtonClicked = state.isSelected;
            selectedIndexes = state.selectedIndexes;
            if (state.type == "screen") {
              productStyleResponse
                      .data![state.selectedIndexes]
                      .variants![productVarientIndex]
                      .userCartQuantity =
                  (productStyleResponse
                          .data![state.selectedIndexes]
                          .variants![productVarientIndex]
                          .userCartQuantity ??
                      0) +
                  1;
              context.read<ProductListBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId:
                      productStyleResponse
                          .data![state.selectedIndexes]
                          .productId ??
                      "",
                  quantity: 1,
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .label
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .label
                            .toString(),
                  imageUrl: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .imageUrl
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .imageUrl
                            .toString(),
                  price: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![productVarientIndex]
                                .price ??
                            0
                      : productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![0]
                                .price ??
                            0,
                  discountPrice: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![productVarientIndex]
                                .discountPrice ??
                            0
                      : productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![0]
                                .discountPrice ??
                            0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "dialog") {
              productStyleResponse
                      .data![state.selectedIndexes]
                      .variants![productVarientIndex]
                      .userCartQuantity =
                  (productStyleResponse
                          .data![state.selectedIndexes]
                          .variants![productVarientIndex]
                          .userCartQuantity ??
                      0) +
                  1;
              debugPrint(
                productStyleResponse
                    .data![state.selectedIndexes]
                    .variants![productVarientIndex]
                    .label
                    .toString(),
              );

              context.read<ProductListBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId:
                      productStyleResponse
                          .data![state.selectedIndexes]
                          .productId ??
                      "",
                  quantity: 1,
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .label
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .label
                            .toString(),
                  imageUrl: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .imageUrl
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .imageUrl
                            .toString(),
                  price: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![productVarientIndex]
                                .price ??
                            0
                      : productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![0]
                                .price ??
                            0,
                  discountPrice: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![productVarientIndex]
                                .discountPrice ??
                            0
                      : productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![0]
                                .discountPrice ??
                            0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            }
            // itemCount.add(1);
          } else if (state is ItemAddedToCartState) {
            context.read<ProductListBloc>().add(
              CartLengthEvent(userId: userId),
            );
            context.read<ProductListBloc>().add(
              ProductStyleEvent(
                mobilNo: phoneNumber,
                userId: userId,
                isMainCategory: widget.isMainCategory,
                mainCatId: widget.mainCatId,
                isSubCategory: true,
                subCatId: subCatList[isSelected].id ?? "",
                page: page,
              ),
            );
          } else if (state is RemoveButtonClickedState) {
            if (state.type == "screen") {
              productStyleResponse
                          .data![state.selectedIndexes]
                          .variants![productVarientIndex]
                          .userCartQuantity ==
                      0
                  ? null
                  : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .userCartQuantity =
                        (productStyleResponse
                                .data![state.selectedIndexes]
                                .variants![productVarientIndex]
                                .userCartQuantity ??
                            0) -
                        1;
              context.read<ProductListBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId:
                      productStyleResponse
                          .data![state.selectedIndexes]
                          .productId ??
                      "",
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .label
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .label
                            .toString(),
                  quantity: 1,
                  handlingCharges: 0,
                  deliveryTip: 0,
                ),
              );
            } else if (state.type == "dialog") {
              productStyleResponse
                      .data![state.selectedIndexes]
                      .variants![productVarientIndex]
                      .userCartQuantity =
                  (productStyleResponse
                          .data![state.selectedIndexes]
                          .variants![productVarientIndex]
                          .userCartQuantity ??
                      0) -
                  1;
              // debugPrint(productStyleResponse.data![state.selectedIndexes]
              //     .variants![productVarientIndex].label
              //     .toString());

              context.read<ProductListBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId:
                      productStyleResponse
                          .data![state.selectedIndexes]
                          .productId ??
                      "",
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![productVarientIndex]
                            .label
                            .toString()
                      : productStyleResponse
                            .data![state.selectedIndexes]
                            .variants![0]
                            .label
                            .toString(),
                  quantity: 1,
                  deliveryTip: 0,
                  handlingCharges: 0,
                ),
              );
            }
          } else if (state is ItemRemovedToCartState) {
            context.read<ProductListBloc>().add(
              CartLengthEvent(userId: userId),
            );
            context.read<ProductListBloc>().add(
              ProductStyleEvent(
                mobilNo: phoneNumber,
                userId: userId,
                isMainCategory: widget.isMainCategory,
                mainCatId: widget.mainCatId,
                isSubCategory: true,
                subCatId: subCatList[isSelected].id ?? "",
                page: page,
              ),
            );
          } else if (state is ProductDetailSuccessState) {
            productDetailResponse = state.productDetailResponse;
            // ShowCaseWidget.of(context).startShowCase([_widgetKey2, _widgetKey]);
            // debugPrint(productDetailResponse.data!.product!.skuName);
          } else if (state is SubCategoryLoadedState) {
            debugPrint('hello sub');
            debugPrint(state.subCategory.data![0].toJson().toString());
            subCatList = state.subCategory.data ?? [];
            subCategoryId = subCatList.isEmpty ? "" : subCatList[0].id ?? "";
            page = 1;
            context.read<ProductListBloc>().add(
              ProductStyleEvent(
                mobilNo: phoneNumber,
                userId: userId,
                isMainCategory: widget.isMainCategory,
                mainCatId: widget.mainCatId,
                isSubCategory: true,
                subCatId: subCatList.isEmpty ? "" : subCatList[0].id ?? "",
                page: page,
              ),
            );
          } else if (state is ProductStyleLoadedState) {
            isLoading = false;
            // debugPrint(state.productStyleResponse.data![0].skuName);
            productStyleResponse = state.productStyleResponse;
            context.read<ProductListBloc>().add(
              GetProductDetailEvent(
                mobileNo: phoneNumber,
                productId:
                    productStyleResponse.data![selectedIndexes].productId ?? "",
              ),
            );
            page = page + 1;
          } else if (state is VarientChangedState) {
            productIndex = state.productIndex;
            productVarientIndex = state.varientIndex;
            selectedProductIndexes = state.productIndex;

            debugPrint(
              '${productStyleResponse.data![productIndex].variants![productVarientIndex].userCartQuantity} - ${productStyleResponse.data![productIndex].variants![productVarientIndex].label}',
            );
          } else if (state is ProductErrorState) {
            isLoading = false;
            productStyleResponse = ProductStyleResponse();
            if (state.message == "No products match the given criteria") {
              errorMsg =
                  "We're cooking up something awesome. Check back soon for new arrivals!";
            } else {
              errorMsg = state.message;
            }

            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent &&
                !isLoading) {
              // Trigger an event to load more data when the user scrolls to the end
              isLoading = true;
              context.read<ProductListBloc>().add(
                ProductStyleEvent(
                  mobilNo: phoneNumber,
                  userId: userId,
                  isMainCategory: widget.isMainCategory,
                  mainCatId: widget.mainCatId,
                  isSubCategory: true,
                  subCatId: subCatList.isEmpty
                      ? ""
                      : subCatList[isSelected].id ?? "",
                  page: page, // Increment the page number
                ),
              );
            }
          });
          if (state is ProductInitialState) {
            errorMsg = "";
            isSelected = 0;
            productIndex = 0;
            productVarientIndex = 0;
            selectedProductIndexes = 0;
            ProductListBloc.productList = [];
            context.read<ProductListBloc>().add(
              CartLengthEvent(userId: userId),
            );
            debugPrint('hi 1');
            context.read<ProductListBloc>().add(
              GetSubCategoryEvent(
                isMainCategory: true,
                mainCatId: widget.mainCatId,
                isCat: widget.isCategory,
                catId: widget.catId,
                mobileNo: phoneNumber,
                userId: userId,
              ),
            );
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading: state is ProductLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Scaffold(
                backgroundColor: const Color(0xFFFAFAFA),
                appBar: AppBar(
                  backgroundColor: headerColor,
                  surfaceTintColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
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
                                SearchScreen(searchTitle: widget.title),
                          ),
                        );
                      },
                      icon: Icon(Icons.search, color: headerComponentsColor),
                    ),
                  ],
                  elevation: headerElevation,
                  title: Text(
                    widget.title,
                    style: TextStyle(color: headerComponentsColor),
                  ),
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
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${cartCount} Item",
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
                                  InkWell(
                                    onTap: () {
                                      // Navigator.pushNamed(context, '/cart')
                                      //     .then((value) {
                                      //   // if (value == true) {
                                      //   if (!context.mounted) return;
                                      //   context.read<ProductListBloc>().add(
                                      //       ProductStyleEvent(
                                      //           mobilNo: phoneNumber,
                                      //           userId: userId,
                                      //           isMainCategory:
                                      //               isMainCategory,
                                      //           mainCatId: mainCatId,
                                      //           isSubCategory: true,
                                      //           subCatId:
                                      //               subCatList[isSelected]
                                      //                       .id ??
                                      //                   "",
                                      //           page: page));
                                      // });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CartScreen(
                                              fromScreen: 'productlist',
                                            );
                                          },
                                        ),
                                      ).then((value) {
                                        // if (value == true) {
                                        selectedIndexes = 0;
                                        ProductListBloc.productList = [];
                                        page = 1;
                                        // Scroll to the top
                                        _scrollController.animateTo(
                                          0.0,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                        if (!context.mounted) return;
                                        context.read<ProductListBloc>().add(
                                          CartLengthEvent(userId: userId),
                                        );
                                        context.read<ProductListBloc>().add(
                                          ProductStyleEvent(
                                            mobilNo: phoneNumber,
                                            userId: userId,
                                            isMainCategory:
                                                widget.isMainCategory,
                                            mainCatId: widget.mainCatId,
                                            isSubCategory: true,
                                            subCatId:
                                                subCatList[isSelected].id ?? "",
                                            page: page,
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
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: widget.isMainCategory || widget.isCategory,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: subCatList.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                selectedIndexes = 0;
                                productDetailResponse = ProductDetailResponse();
                                context.read<ProductListBloc>().add(
                                  OnSelectEvent(
                                    index: i,
                                    name: subCatList[i].name ?? "",
                                  ),
                                );

                                // Scroll to the top
                                _scrollController.positions.isEmpty
                                    ? null
                                    : _scrollController.animateTo(
                                        0.0,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                              },
                              child: Container(
                                height: 85,
                                color: isSelected == i
                                    ? backgroundTileColor
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    if (isSelected == i)
                                      Container(width: 4, color: appColor),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NetworkImageWidget(
                                            url: subCatList[i].imageUrl ?? "",
                                            width: 53,
                                            height: 53,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            subCatList[i].name ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
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
                      ),
                    ),
                    if (productStyleResponse.data == null)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                errorMsg,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (productStyleResponse.data != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double screenWidth = constraints.maxWidth;
                              double itemWidth =
                                  screenWidth / 2 - 10; // Adjust for spacing
                              double itemHeight =
                                  itemWidth * 1.8; // Adjust height dynamically
                              return GridView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio:
                                          itemWidth /
                                          itemHeight, // Dynamic aspect ratio
                                    ),
                                itemCount:
                                    context.read<ProductListBloc>().page >= page
                                    ? productStyleResponse.data!.length + 1
                                    : productStyleResponse.data!.length,
                                itemBuilder: (context, index) {
                                  if (index ==
                                          productStyleResponse.data!.length &&
                                      context.read<ProductListBloc>().page >=
                                          page) {
                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: appColor,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: itemWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        spacing: 3,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ProductDetailsScreen(
                                                        productId:
                                                            productStyleResponse
                                                                .data![index]
                                                                .productId ??
                                                            "",
                                                        screenType: "",
                                                      );
                                                    },
                                                  ),
                                                ).then((value) {
                                                  // Scroll to the top
                                                  _scrollController.animateTo(
                                                    0.0,
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  if (!context.mounted) {
                                                    return;
                                                  }
                                                  debugPrint(
                                                    cartCount.toString(),
                                                  );
                                                  selectedIndexes = 0;
                                                  ProductListBloc.productList =
                                                      [];
                                                  page = 1;
                                                  context
                                                      .read<ProductListBloc>()
                                                      .add(
                                                        ProductStyleEvent(
                                                          mobilNo: phoneNumber,
                                                          userId: userId,
                                                          isMainCategory: widget
                                                              .isMainCategory,
                                                          mainCatId:
                                                              widget.mainCatId,
                                                          isSubCategory: true,
                                                          subCatId:
                                                              subCatList[isSelected]
                                                                  .id ??
                                                              "",
                                                          page: page,
                                                        ),
                                                      );
                                                  context
                                                      .read<ProductListBloc>()
                                                      .add(
                                                        CartLengthEvent(
                                                          userId: userId,
                                                        ),
                                                      );
                                                });
                                                // Navigator.pushNamed(
                                                //     context, '/productDetailsScreen');
                                                // debugPrint(productStyleResponse
                                                //     .data![index].productId);
                                              },
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 12.0,
                                                          ),
                                                      child: NetworkImageWidget(
                                                        url:
                                                            selectedProductIndexes ==
                                                                index
                                                            ? productStyleResponse
                                                                      .data![index]
                                                                      .variants![productVarientIndex]
                                                                      .isComboPack!
                                                                  ? productStyleResponse
                                                                            .data![index]
                                                                            .variants![productVarientIndex]
                                                                            .comboDetails!
                                                                            .comboImageUrl ??
                                                                        ""
                                                                  : productStyleResponse
                                                                            .data![index]
                                                                            .variants![productVarientIndex]
                                                                            .imageUrl ??
                                                                        ""
                                                            : productStyleResponse
                                                                      .data![index]
                                                                      .variants![0]
                                                                      .imageUrl ??
                                                                  "",
                                                        fit: BoxFit.contain,
                                                        width:
                                                            itemWidth, // Ensure the width is fixed
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
                                                      decoration: BoxDecoration(
                                                        color: appColor,
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
                                                        selectedProductIndexes ==
                                                                index
                                                            ? productStyleResponse
                                                                      .data![index]
                                                                      .variants![productVarientIndex]
                                                                      .offer ??
                                                                  ""
                                                            : productStyleResponse
                                                                      .data![index]
                                                                      .variants![0]
                                                                      .offer ??
                                                                  "",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  productStyleResponse
                                                          .data![index]
                                                          .skuName ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 6),
                                                index == 0
                                                    ? Showcase(
                                                        tooltipBackgroundColor:
                                                            Colors.white,
                                                        descTextStyle:
                                                            TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                        key: _widgetKey,
                                                        description:
                                                            'Tap here to view product variants',
                                                        child: InkWell(
                                                          onTap: () {
                                                            debugPrint(
                                                              selectedProductIndexes
                                                                  .toString(),
                                                            );
                                                            showProductBottomSheet(
                                                              context,
                                                              productStyleResponse
                                                                      .data![index]
                                                                      .skuName ??
                                                                  "",
                                                              index,
                                                              context
                                                                  .read<
                                                                    ProductListBloc
                                                                  >(),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: appColor
                                                                    .withAlpha(
                                                                      120,
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
                                                                    selectedProductIndexes ==
                                                                            index
                                                                        ? productStyleResponse.data![index].variants![productVarientIndex].label ??
                                                                              ""
                                                                        : productStyleResponse.data![index].variants![0].label ??
                                                                              "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .black,
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
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          debugPrint(
                                                            selectedProductIndexes
                                                                .toString(),
                                                          );
                                                          showProductBottomSheet(
                                                            context,
                                                            productStyleResponse
                                                                    .data![index]
                                                                    .skuName ??
                                                                "",
                                                            index,
                                                            context
                                                                .read<
                                                                  ProductListBloc
                                                                >(),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 4,
                                                                vertical: 8,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: appColor
                                                                  .withAlpha(
                                                                    120,
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
                                                                  selectedProductIndexes ==
                                                                          index
                                                                      ? productStyleResponse.data![index].variants![productVarientIndex].label ??
                                                                            ""
                                                                      : productStyleResponse.data![index].variants![0].label ??
                                                                            "",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black,
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
                                                SizedBox(height: 6),
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
                                                            text:
                                                                '${selectedProductIndexes == index ? productStyleResponse.data![index].variants![productVarientIndex].discountPrice ?? "" : productStyleResponse.data![index].variants![0].discountPrice ?? ""}',
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
                                                    SizedBox(width: 6),
                                                    Text(
                                                      selectedProductIndexes ==
                                                              index
                                                          ? productStyleResponse
                                                                .data![index]
                                                                .variants![productVarientIndex]
                                                                .price
                                                                .toString()
                                                          : productStyleResponse
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
                                                            FontWeight.w600,
                                                        color: Color(
                                                          0xFF777777,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                (selectedProductIndexes == index
                                                            ? productStyleResponse
                                                                      .data![index]
                                                                      .variants![productVarientIndex]
                                                                      .userCartQuantity ??
                                                                  0
                                                            : productStyleResponse
                                                                      .data![index]
                                                                      .variants![0]
                                                                      .userCartQuantity ??
                                                                  0) ==
                                                        0
                                                    ? index == 0
                                                          ? Showcase(
                                                              targetShapeBorder:
                                                                  const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                          Radius.circular(
                                                                            20,
                                                                          ),
                                                                        ),
                                                                  ),
                                                              tooltipBackgroundColor:
                                                                  Colors.white,
                                                              descTextStyle:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                              key: _widgetKey2,
                                                              description:
                                                                  'Tap here to add products to cart',
                                                              child: InkWell(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        ChangeVarientItemEvent(
                                                                          productIndex:
                                                                              index,
                                                                          varientIndex:
                                                                              selectedProductIndexes ==
                                                                                  index
                                                                              ? productVarientIndex
                                                                              : 0,
                                                                        ),
                                                                      );
                                                                  context
                                                                      .read<
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        AddButtonClikedEvent(
                                                                          type:
                                                                              "screen",
                                                                          index:
                                                                              index,
                                                                          isButtonPressed:
                                                                              true,
                                                                        ),
                                                                      );
                                                                },
                                                                child: Container(
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            1,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        whitecolor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          20,
                                                                        ),
                                                                    border: Border.all(
                                                                      color:
                                                                          appColor,
                                                                    ),
                                                                  ),
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
                                                                        style: GoogleFonts.poppins(
                                                                          color:
                                                                              appColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                context
                                                                    .read<
                                                                      ProductListBloc
                                                                    >()
                                                                    .add(
                                                                      ChangeVarientItemEvent(
                                                                        productIndex:
                                                                            index,
                                                                        varientIndex:
                                                                            selectedProductIndexes ==
                                                                                index
                                                                            ? productVarientIndex
                                                                            : 0,
                                                                      ),
                                                                    );
                                                                context
                                                                    .read<
                                                                      ProductListBloc
                                                                    >()
                                                                    .add(
                                                                      AddButtonClikedEvent(
                                                                        type:
                                                                            "screen",
                                                                        index:
                                                                            index,
                                                                        isButtonPressed:
                                                                            true,
                                                                      ),
                                                                    );
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          1,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      whitecolor,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        20,
                                                                      ),
                                                                  border: Border.all(
                                                                    color:
                                                                        appColor,
                                                                  ),
                                                                ),
                                                                height: 27,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Add",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                        color:
                                                                            appColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                    : Container(
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
                                                        height: 27,
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
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        ChangeVarientItemEvent(
                                                                          productIndex:
                                                                              index,
                                                                          varientIndex:
                                                                              selectedProductIndexes ==
                                                                                  index
                                                                              ? productVarientIndex
                                                                              : 0,
                                                                        ),
                                                                      );
                                                                  context
                                                                      .read<
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        RemoveItemButtonClikedEvent(
                                                                          type:
                                                                              "screen",
                                                                          index:
                                                                              index,
                                                                          isButtonPressed:
                                                                              true,
                                                                          variantIndex:
                                                                              productVarientIndex,
                                                                        ),
                                                                      );
                                                                },
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
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
                                                                selectedProductIndexes ==
                                                                        index
                                                                    ? productStyleResponse
                                                                              .data![index]
                                                                              .variants![productVarientIndex]
                                                                              .userCartQuantity
                                                                              ?.toString() ??
                                                                          "0"
                                                                    : productStyleResponse
                                                                              .data![index]
                                                                              .variants![0]
                                                                              .userCartQuantity
                                                                              ?.toString() ??
                                                                          "0",
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
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        ChangeVarientItemEvent(
                                                                          productIndex:
                                                                              index,
                                                                          varientIndex:
                                                                              selectedProductIndexes ==
                                                                                  index
                                                                              ? productVarientIndex
                                                                              : 0,
                                                                        ),
                                                                      );
                                                                  context
                                                                      .read<
                                                                        ProductListBloc
                                                                      >()
                                                                      .add(
                                                                        AddButtonClikedEvent(
                                                                          type:
                                                                              "screen",
                                                                          index:
                                                                              index,
                                                                          isButtonPressed:
                                                                              true,
                                                                        ),
                                                                      );
                                                                },
                                                                child: const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 16,
                                                                ),
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
}
