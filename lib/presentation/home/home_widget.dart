import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:sodakkuapp/model/category/dynamic_category_model.dart';
import 'package:sodakkuapp/model/category/dynamic_category_model.dart'
    as dynamiccatmodel;
import 'package:sodakkuapp/model/home/dynamic_product_style_response_model.dart';
import 'package:sodakkuapp/presentation/category/category_bloc.dart';
import 'package:sodakkuapp/presentation/category/category_event.dart';
import 'package:sodakkuapp/presentation/category/category_state.dart';
import 'package:sodakkuapp/presentation/home/cart_increment_cubit.dart';
import 'package:sodakkuapp/presentation/home/home_bloc.dart';
import 'package:sodakkuapp/presentation/home/home_event.dart';
import 'package:sodakkuapp/presentation/home/home_state.dart';
import 'package:sodakkuapp/presentation/location/location_screen.dart';
import 'package:sodakkuapp/model/category/category_model.dart' as catmodel;
import 'package:sodakkuapp/model/category/main_category_model.dart';
import 'package:sodakkuapp/model/category/product_style_model.dart';
import 'package:sodakkuapp/model/home/banner_model.dart';
import 'package:sodakkuapp/model/home/grab_essentials_model.dart';
import 'package:sodakkuapp/presentation/banner/banner_screen.dart';
import 'package:sodakkuapp/presentation/productdetails/product_details_screen.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_menu.dart';
import 'package:sodakkuapp/presentation/search/search_screen.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeWidgetScreen extends StatelessWidget {
  const HomeWidgetScreen({super.key});

  static GrabandEssential grabandEssential = GrabandEssential();
  static MainCategory mainCategory = MainCategory();
  static DynamicCategories dynamicCategories = DynamicCategories();

  static TextEditingController searchController = TextEditingController();

  static List<catmodel.Category> categories = [];
  static List<BannerList> festivalbanners = [];
  static List<BannerList> dailybanners = [];
  static List<BannerList> offerbanners = [];
  static List<BannerList> offerbanners10 = [];
  static List<BannerList> dealsbanners = [];
  static ProductStyleResponse freshFruitsresponse = ProductStyleResponse();
  static ProductStyleResponse groceryEssentialsResponse =
      ProductStyleResponse();
  static ProductStyleResponse nutsDriedFruitsResponse = ProductStyleResponse();
  static ProductStyleResponse riceCerealsResponse = ProductStyleResponse();
  static PageController pageController = PageController(initialPage: 0);
  static int currentPage = 0;
  static Timer? timer;
  static List<BannerList> loopingBanners = [];
  static bool addButtonClicked = false;
  static int selectedIndexes = 0;
  static int selectedProductIndexes = 0;
  static int productVarientIndex = 0;

  void showLocationBottomSheet(
    BuildContext context,
    String latitude,
    String longitude,
    String place,
    HomeBloc homebloc,
  ) {
    showModalBottomSheet(
      backgroundColor: whitecolor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      isDismissible: !(location == "No Location Found"),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          //  height: 250,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(locationImage),
              // SizedBox(height: 20),
              Column(
                spacing: 10,
                children: [
                  Text(
                    "Please Enable Location Permission",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "for better delivery experience",
                    style: TextStyle(color: greyColor),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  spacing: 20,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homebloc.add(ContinueLocationEvent());
                        Navigator.pop(context);
                        // Navigator.pushNamed(context, "/yourLocation");
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return YourLocationScreen(
                        //         latitude: latitude,
                        //         longitude: longitude,
                        //         place: place);
                        //   },
                        // ));
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              //  fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: whitecolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LocationScreen(screenType: 'dialog');
                            },
                          ),
                        );
                        if (res != null) {
                          debugPrint(res);
                          homebloc.add(UpdateLocationEvent(location: res));
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: appColor),
                          //color: const appColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: appColor),
                              Text(
                                "Search Your Location",
                                style: TextStyle(
                                  //  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: appColor,
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
            ],
          ),
        );
      },
    ) /* .whenComplete(() => context.read<BottomSheetBloc>().add(HideBottomSheetEvent())) */; // Hide when dismissed
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GrabandEssentialsLoadedState) {
            debugPrint("Grab and go essentials");
            debugPrint('${state.grabandEssential.data![0].toJson()}');
            grabandEssential = state.grabandEssential;
          } else if (state is BannerLoadedState) {
            festivalbanners = [];
            dailybanners = [];
            offerbanners = [];
            debugPrint(state.banners.message);
            for (int i = 0; i < state.banners.data!.length; i++) {
              if (state.banners.data![i].bannerType == "Festival offers") {
                festivalbanners.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "Product Offer") {
                dailybanners.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "Week Offer") {
                offerbanners.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "10% Offer") {
                offerbanners10.add(state.banners.data![i]);
              } else if (state.banners.data![i].bannerType == "Deals offers") {
                dealsbanners.add(state.banners.data![i]);
              }
            }
          } else if (state is OrganicFreshFruitsLoadedState) {
            freshFruitsresponse = ProductStyleResponse();
            // freshFruitsList = state.productStyleResponse.data ?? [];
            freshFruitsresponse = state.productStyleResponse;
          } else if (state is GroceryEssentialsLoadedState) {
            // groceryEssentials = state.productStyleResponse.data ?? [];
            groceryEssentialsResponse = ProductStyleResponse();
            groceryEssentialsResponse = state.productStyleResponse;
          } else if (state is NutsDriedFruitsLoadedState) {
            // nutsDriedFruits = state.productStyleResponse.data ?? [];
            nutsDriedFruitsResponse = ProductStyleResponse();
            nutsDriedFruitsResponse = state.productStyleResponse;
          } else if (state is RiceCerealsLoadedState) {
            //  riceCerealsList = state.productStyleResponse.data ?? [];
            riceCerealsResponse = ProductStyleResponse();
            riceCerealsResponse = state.productStyleResponse;
          } else if (state is DynamicProductStyleResponseState) {
            context.read<HomeBloc>().dynamicProducts = state.products;
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
          } else if (state is LocationSuccessState) {
            showLocationBottomSheet(
              context,
              state.latitude ?? "",
              state.longitude ?? "",
              state.place!,
              context.read<HomeBloc>(),
            );
          } else if (state is LocationContinueSuccessState) {
            location = state.place ?? "";
          } else if (state is UpdateLocationState) {
            location = state.location;
          } else if (state is AddButtonClickedState) {
            // noOfIteminCart = noOfIteminCart + 1;
            // context.read<CounterCubit>().increment();
            addButtonClicked = state.isSelected;
            selectedIndexes = state.selectedIndexes;
            if (state.type == "screen") {
              state.response.variants![0].cartQuantity =
                  (state.response.variants![0].cartQuantity ?? 0) + 1;
              context.read<HomeBloc>().add(
                AddItemInCartApiEvent(
                  userId: userId,
                  productId: state.response.id ?? "",
                  quantity: 1,
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? state.response.variants![productVarientIndex].label
                            .toString()
                      : state.response.variants![0].label.toString(),
                  imageUrl: selectedProductIndexes == state.selectedIndexes
                      ? state.response.variants![productVarientIndex].imageUrl
                            .toString()
                      : state.response.variants![0].imageUrl.toString(),
                  price: selectedProductIndexes == state.selectedIndexes
                      ? state.response.variants![productVarientIndex].price ?? 0
                      : state.response.variants![0].price ?? 0,
                  discountPrice: selectedProductIndexes == state.selectedIndexes
                      ? state
                                .response
                                .variants![productVarientIndex]
                                .discountPrice ??
                            0
                      : state.response.variants![0].discountPrice ?? 0,
                  deliveryInstructions: "",
                  addNotes: "",
                ),
              );
            } else if (state.type == "dialog") {
              state.response.variants![state.selectedIndexes].cartQuantity =
                  (state
                          .response
                          .variants![state.selectedIndexes]
                          .cartQuantity ??
                      0) +
                  1;
            }
          } else if (state is ItemAddedToCartInHomeScreenState) {
            //   context.read<CounterCubit>().increment(1);
            context.read<HomeBloc>().add(GetDynamicHomeProductEvent());
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
          } else if (state is CartDataSuccess) {
            // context.read<CounterCubit>().decrement(state.noOfItems);
            noOfIteminCart = state.noOfItems;
            context.read<HomeBloc>().add(
              GetScreenEvent(cartcount: state.noOfItems, index: 0),
            );
            context.read<CounterCubit>().increment(state.noOfItems);
            noOfIteminCart = state.noOfItems;
          } else if (state is RemoveButtonClickedState) {
            // noOfIteminCart = noOfIteminCart - 1;
            if (state.type == "screen") {
              state.response.variants![0].cartQuantity == 0
                  ? null
                  : state.response.variants![0].cartQuantity =
                        (state.response.variants![0].cartQuantity ?? 0) - 1;
              context.read<HomeBloc>().add(
                RemoveItemInCartApiEvent(
                  userId: userId,
                  productId: state.response.id ?? "",
                  variantLabel: selectedProductIndexes == state.selectedIndexes
                      ? state.response.variants![productVarientIndex].label
                            .toString()
                      : state.response.variants![0].label.toString(),
                  quantity: 1,
                  deliveryTip: 0,
                  handlingCharges: 0,
                ),
              );
            } else if (state.type == "dialog") {
              state.response.variants![state.selectedIndexes].cartQuantity =
                  (state
                          .response
                          .variants![state.selectedIndexes]
                          .cartQuantity ??
                      0) -
                  1;
            }
          } else if (state is ItemRemovedToCartState) {
            context.read<HomeBloc>().add(GetDynamicHomeProductEvent());
          } else if (state is HomeErrorState) {
            if (state.message == "Failed to fetch data") {
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              location == "No Location Found"
                  ? context.read<HomeBloc>().add(GetLocationEvent())
                  : null;
            });
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
            context.read<HomeBloc>().add(GrabAndGoEvent());
            context.read<HomeBloc>().add(GetBannerEvent());
            context.read<HomeBloc>().add(GetDynamicHomeProductEvent());
            context.read<CategoryBloc>().add(GetMainCategoryDataEvent());
            context.read<CategoryBloc>().add(GetCategoryDataEvent());
            context.read<CategoryBloc>().add(GetDynamicCategoryDataEvent());
            context.read<HomeBloc>().add(
              GetOrganicFruitsEvent(
                mainCatId: "676431a2edae32578ae6d220",
                subCatId: "676ad87c756fa03a5d0d0616",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetGroceryEssentialsEvent(
                subCatId: "676b624a84dd76eac5d33a3e",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetNutsDriedFruitsEvent(
                subCatId: "676b62c484dd76eac5d33a46",
                mobileNo: phoneNumber,
              ),
            );
            context.read<HomeBloc>().add(
              GetRiceCerealsEvent(
                mainCatId: "676431ddedae32578ae6d222",
                subCatId: "676b60bd84dd76eac5d33a2a",
                mobileNo: phoneNumber,
              ),
            );

            timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
              if (pageController.hasClients) {
                currentPage++;

                if (currentPage == festivalbanners.length + 1) {
                  // If reached the fake last item, jump to first real image instantly
                  pageController.jumpToPage(1);
                  currentPage = 1;
                } else {
                  // Otherwise, move to the next image
                  pageController.animateToPage(
                    currentPage,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              }
            });
          }
          return OverlayLoaderWithAppIcon(
            appIconSize: 60,
            circularProgressColor: Colors.transparent,
            overlayBackgroundColor: Colors.black87,
            isLoading:
                state is HomeLoadingState || state is CategoryLoadingState,
            appIcon: Image.asset(loadGif, fit: BoxFit.fill),
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is MainCategoryLoadedState) {
                  mainCategory = state.mainCategory;
                } else if (state is CategoryLoadedState) {
                  categories = state.categories;
                } else if (state is DynamicCategoryLoadedState) {
                  dynamicCategories = state.categories;
                  debugPrint('home dynamic');
                  debugPrint(dynamicCategories.toJson().toString());
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        homeTop,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              whitecolor,
                              whitecolor,
                            ], // Start & End Colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                        GetLocationEvent(),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.6,
                                          ),
                                          child: Text(
                                            location, // Your dynamic text here
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/settings');
                                    },
                                    child: SvgPicture.asset(
                                      profilesvg,
                                      height: 24,
                                      width: 24,
                                      colorFilter: ColorFilter.mode(
                                        appColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(searchTitle: "Orange"),
                                    ),
                                  );
                                },
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
                                      Icon(Icons.search, color: Colors.black54),
                                      SizedBox(width: 8),
                                      Text(
                                        "Search For 'Orange'",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      // Expanded(
                                      //   child: TextFormField(
                                      //     controller: searchController,
                                      //     onTap: () {
                                      //       Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               SearchScreen(),
                                      //         ),
                                      //       );
                                      //     },
                                      //     style: TextStyle(
                                      //       fontSize: 16,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     decoration: InputDecoration(
                                      //       fillColor: Color(0xFFFFFFFF),
                                      //       hintText: 'Search For "Orange"',
                                      //       hintStyle:
                                      //           TextStyle(color: Colors.black54),
                                      //       border: InputBorder.none,
                                      //     ),
                                      //     onChanged: (value) {},
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Grab & Go essentials for you!",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Visibility(
                              visible: !(grabandEssential.data == null),
                              child: IntrinsicHeight(
                                child: Row(
                                  spacing: 12,
                                  children: [
                                    if (grabandEssential.data != null)
                                      for (
                                        int i = 0;
                                        i < grabandEssential.data!.length;
                                        i++
                                      )
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              title =
                                                  grabandEssential
                                                      .data![i]
                                                      .name ??
                                                  "";
                                              id =
                                                  grabandEssential
                                                      .data![i]
                                                      .categoryId ??
                                                  "";
                                              isMainCategory = true;
                                              mainCatId =
                                                  grabandEssential
                                                      .data![i]
                                                      .categoryId ??
                                                  "";
                                              isCategory = true;
                                              catId =
                                                  grabandEssential
                                                      .data![i]
                                                      .categoryId ??
                                                  "";
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductListMenuScreen(
                                                        title:
                                                            grabandEssential
                                                                .data![i]
                                                                .name ??
                                                            "",
                                                        id:
                                                            grabandEssential
                                                                .data![i]
                                                                .categoryId ??
                                                            "",
                                                        isMainCategory: true,
                                                        mainCatId:
                                                            grabandEssential
                                                                .data![i]
                                                                .categoryId ??
                                                            "",
                                                        isCategory: true,
                                                        catId:
                                                            grabandEssential
                                                                .data![i]
                                                                .categoryId ??
                                                            "",
                                                      ),
                                                ),
                                              ).then((value) {
                                                if (!context.mounted) return;
                                                context.read<HomeBloc>().add(
                                                  GetCartCountEvent(
                                                    userId: userId,
                                                  ),
                                                );
                                                // context
                                                //     .read<CounterCubit>()
                                                //     .decrement(cartCount);
                                                context
                                                    .read<CounterCubit>()
                                                    .increment(cartCount);
                                                noOfIteminCart = cartCount;
                                              });
                                            },
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    grabandEssential
                                                            .data![i]
                                                            .imageUrl ??
                                                        "",
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    // padding: EdgeInsets.only(
                                                    //     top: 4,
                                                    //     bottom: 4,
                                                    //     left: 20,
                                                    //     right: 20),
                                                    margin: EdgeInsets.only(
                                                      top: 3,
                                                      right: 3,
                                                      left: 3,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: whitecolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 4,
                                                        bottom: 4,
                                                        left: 15,
                                                        right: 15,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          grabandEssential
                                                                  .data![i]
                                                                  .name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
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
                            SizedBox(height: 8),
                            festivalbanners.isEmpty
                                ? SizedBox()
                                : CarouselSlider.builder(
                                    itemCount: festivalbanners.length,
                                    options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          2.5,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(
                                        seconds: 5,
                                      ),
                                      autoPlayAnimationDuration: const Duration(
                                        milliseconds: 800,
                                      ),
                                      // enlargeCenterPage:
                                      //     true, // Gives a nice zoom effect
                                      viewportFraction:
                                          0.9, // Makes items slightly smaller than screen width
                                      scrollDirection: Axis.horizontal,
                                      enableInfiniteScroll:
                                          true, // Allows continuous looping
                                      onPageChanged: (index, reason) {
                                        // setState(() {
                                        //   _currentIndex = index;
                                        // });
                                      },
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      return InkWell(
                                        onTap: () async {
                                          var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BannerScreen(
                                                    bannerId:
                                                        festivalbanners[index]
                                                            .id ??
                                                        "",
                                                  ),
                                            ),
                                          );
                                          if (result == null ||
                                              result != null) {
                                            if (!context.mounted) return;
                                            context.read<HomeBloc>().add(
                                              GetDynamicHomeProductEvent(),
                                            );
                                            context.read<HomeBloc>().add(
                                              GetCartCountEvent(userId: userId),
                                            );
                                            // context
                                            //     .read<CounterCubit>()
                                            //     .decrement(cartCount);
                                            context
                                                .read<CounterCubit>()
                                                .increment(cartCount);
                                            noOfIteminCart = cartCount;
                                          }
                                          //     .then(
                                          //   (value) {
                                          //     if (!context.mounted) return;
                                          //     context.read<HomeBloc>().add(
                                          //         GetCartCountEvent(
                                          //             userId: userId));
                                          //     context
                                          //         .read<CounterCubit>()
                                          //         .increment(cartCount);
                                          //     noOfIteminCart = cartCount;
                                          //   },
                                          // );
                                          debugPrint(festivalbanners[index].id);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: NetworkImageWidget(
                                              url:
                                                  festivalbanners[index]
                                                      .imageUrl ??
                                                  "",
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dailybanners.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return BannerScreen(
                                              bannerId:
                                                  dailybanners[index].id ?? "",
                                            );
                                          },
                                        ),
                                      );
                                      if (result == null || result != null) {
                                        if (!context.mounted) return;
                                        context.read<HomeBloc>().add(
                                          GetDynamicHomeProductEvent(),
                                        );
                                        context.read<HomeBloc>().add(
                                          GetCartCountEvent(userId: userId),
                                        );
                                        context.read<CounterCubit>().increment(
                                          cartCount,
                                        );
                                        noOfIteminCart = cartCount;
                                      }
                                      debugPrint(dailybanners[index].id);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Container(
                                        width: 314,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: NetworkImageWidget(
                                            url:
                                                dailybanners[index].imageUrl ??
                                                "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // SizedBox(height: 8),
                            if (offerbanners10.isNotEmpty) SizedBox(height: 8),
                            if (offerbanners10.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  spacing: 15,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '10% Off on All Your Favorites',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 152,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: offerbanners10.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              var result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return BannerScreen(
                                                      bannerId:
                                                          offerbanners[0].id ??
                                                          "",
                                                    );
                                                  },
                                                ),
                                              );
                                              if (result == null ||
                                                  result != null) {
                                                if (!context.mounted) return;

                                                context.read<HomeBloc>().add(
                                                  GetDynamicHomeProductEvent(),
                                                );
                                                context.read<HomeBloc>().add(
                                                  GetCartCountEvent(
                                                    userId: userId,
                                                  ),
                                                );
                                                context
                                                    .read<CounterCubit>()
                                                    .increment(cartCount);
                                                noOfIteminCart = cartCount;
                                              }
                                              debugPrint(
                                                offerbanners[0].id ?? "",
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              child: Container(
                                                width: 126,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: NetworkImageWidget(
                                                    url:
                                                        offerbanners10[index]
                                                            .imageUrl ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Explore by Categories',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                if (dynamicCategories.data != null)
                                  Visibility(
                                    visible: false,
                                    child: Row(
                                      children: [
                                        Text(
                                          'See All',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: appColor,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                          color: appColor,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            if (dynamicCategories.data != null)
                              for (
                                int categoryIndex = 0;
                                categoryIndex < dynamicCategories.data!.length;
                                categoryIndex++
                              )
                                Column(
                                  children: [
                                    if (dynamicCategories.data!.length > 1)
                                      Row(
                                        children: [
                                          Text(
                                            dynamicCategories
                                                .data![categoryIndex]
                                                .categoryTitleName!,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    if (dynamicCategories.data!.length > 1)
                                      SizedBox(height: 20),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        double screenWidth =
                                            constraints.maxWidth;
                                        double itemWidth =
                                            (screenWidth - (22 * 2)) /
                                            3; // Adjust for crossAxisSpacing
                                        double itemHeight =
                                            itemWidth *
                                            1.2; // Adjust height dynamically

                                        List<dynamiccatmodel.Category>?
                                        categorydata =
                                            [
                                              ...dynamicCategories
                                                  .data![categoryIndex]
                                                  .categories!,
                                            ]..sort(
                                              (a, b) =>
                                                  a.index!.compareTo(b.index!),
                                            );
                                        return StaggeredGrid.count(
                                          crossAxisCount: 48,
                                          // crossAxisCount: 3,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 15,
                                          children: categorydata
                                              .map(
                                                (
                                                  data,
                                                ) => StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      data.isHighlight!
                                                      ? 24
                                                      : 16,
                                                  mainAxisCellCount: 18,
                                                  child: InkWell(
                                                    onTap: () {
                                                      title = data.name ?? "";
                                                      id = data.id ?? "";
                                                      isMainCategory = true;
                                                      mainCatId = data.id ?? "";
                                                      isCategory = true;
                                                      catId = data.id ?? "";
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductListMenuScreen(
                                                                title:
                                                                    data.name ??
                                                                    "",
                                                                id:
                                                                    data.id ??
                                                                    "",
                                                                isMainCategory:
                                                                    true,
                                                                mainCatId:
                                                                    data.id ??
                                                                    "",
                                                                isCategory:
                                                                    true,
                                                                catId:
                                                                    data.id ??
                                                                    "",
                                                              ),
                                                        ),
                                                      ).then((value) {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        context
                                                            .read<HomeBloc>()
                                                            .add(
                                                              GetCartCountEvent(
                                                                userId: userId,
                                                              ),
                                                            );
                                                        // context
                                                        //     .read<CounterCubit>()
                                                        //     .decrement(cartCount);
                                                        context
                                                            .read<
                                                              CounterCubit
                                                            >()
                                                            .increment(
                                                              cartCount,
                                                            );
                                                        noOfIteminCart =
                                                            cartCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height:
                                                              itemHeight *
                                                              0.65, // Dynamically adjust height
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFf6f6f6,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  5,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: appColor
                                                                    .withAlpha(
                                                                      120,
                                                                    ),
                                                                blurRadius: 0,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    8.0,
                                                                  ),
                                                              child: NetworkImageWidget(
                                                                url:
                                                                    data.imageUrl ??
                                                                    "",
                                                                fit: BoxFit
                                                                    .contain,
                                                                width:
                                                                    itemWidth *
                                                                    1.5, // Adjust image width dynamically
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              itemWidth *
                                                              1.1, // Ensure text fits within item width
                                                          child: Text(
                                                            data.name ?? "",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                    0xFF222222,
                                                                  ),
                                                                ),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        );
                                      },
                                    ),
                                    if (dynamicCategories.data!.length > 1)
                                      SizedBox(height: 20),
                                  ],
                                ),
                            //  const BannerCarousel(),
                            //  const SizedBox(height: 26),
                            // const CategoryGrid(),
                            //  const SizedBox(height: 27),
                            if (dealsbanners.isNotEmpty)
                              InkWell(
                                onTap: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BannerScreen(
                                          bannerId: dealsbanners[0].id ?? "",
                                        );
                                      },
                                    ),
                                  );
                                  if (result == null || result != null) {
                                    if (!context.mounted) return;

                                    context.read<HomeBloc>().add(
                                      GetDynamicHomeProductEvent(),
                                    );
                                    context.read<HomeBloc>().add(
                                      GetCartCountEvent(userId: userId),
                                    );
                                    context.read<CounterCubit>().increment(
                                      cartCount,
                                    );
                                    noOfIteminCart = cartCount;
                                  }
                                },
                                child: NetworkImageWidget(
                                  url: dealsbanners[0].imageUrl ?? "",
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            const SizedBox(height: 8),
                            if (offerbanners.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: offerbanners.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return BannerScreen(
                                                  bannerId:
                                                      offerbanners[index].id ??
                                                      "",
                                                );
                                              },
                                            ),
                                          );
                                          if (result == null ||
                                              result != null) {
                                            if (!context.mounted) return;
                                            context.read<HomeBloc>().add(
                                              GetDynamicHomeProductEvent(),
                                            );
                                            context.read<HomeBloc>().add(
                                              GetCartCountEvent(userId: userId),
                                            );
                                            context
                                                .read<CounterCubit>()
                                                .increment(cartCount);
                                            noOfIteminCart = cartCount;
                                          }
                                          debugPrint(offerbanners[index].id);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12,
                                          ),
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: NetworkImageWidget(
                                                url:
                                                    offerbanners[index]
                                                        .imageUrl ??
                                                    "",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            SizedBox(height: 10),

                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            if (context.read<HomeBloc>().dynamicProducts.data !=
                                null)
                              Column(
                                children: context.read<HomeBloc>().dynamicProducts.data!.map((
                                  productdata,
                                ) {
                                  List<Product> product = productdata.products!;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 24.0,
                                    ),
                                    child: Column(
                                      spacing: 16,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              productdata.displayName!,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              for (
                                                int i = 0;
                                                i < product.length;
                                                i++
                                              )
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return ProductDetailsScreen(
                                                            productId:
                                                                product[i].id ??
                                                                "",
                                                            screenType: "back",
                                                          );
                                                        },
                                                      ),
                                                    ).then((value) {
                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      context.read<HomeBloc>().add(
                                                        GetDynamicHomeProductEvent(),
                                                      );

                                                      context
                                                          .read<HomeBloc>()
                                                          .add(
                                                            GetCartCountEvent(
                                                              userId: userId,
                                                            ),
                                                          );
                                                      // context
                                                      //     .read<CounterCubit>()
                                                      //     .decrement(cartCount);
                                                      context
                                                          .read<CounterCubit>()
                                                          .increment(cartCount);
                                                      noOfIteminCart =
                                                          cartCount;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 240,
                                                    width:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        2.3,
                                                    decoration: BoxDecoration(
                                                      color: whitecolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      top: 12.0,
                                                                    ),
                                                                child: NetworkImageWidget(
                                                                  url:
                                                                      product[i]
                                                                          .variants![0]
                                                                          .imageUrl ??
                                                                      "",
                                                                  height: 100,
                                                                  //width: double.infinity,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      appColor,
                                                                  borderRadius: BorderRadius.only(
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
                                                                  product[i]
                                                                          .variants![0]
                                                                          .offer ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
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
                                                              //spacing: 2,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  product[i]
                                                                          .skuName ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  product[i]
                                                                          .variants![0]
                                                                          .label ??
                                                                      "",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
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
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black,
                                                                            ),
                                                                            children:
                                                                                <
                                                                                  TextSpan
                                                                                >[
                                                                                  TextSpan(
                                                                                    text: product[i].variants![0].discountPrice.toString(),
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
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        Text(
                                                                          product[i]
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
                                                                    product[i].variants![0].cartQuantity ==
                                                                            0
                                                                        ? Expanded(
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                context
                                                                                    .read<
                                                                                      HomeBloc
                                                                                    >()
                                                                                    .add(
                                                                                      AddButtonClikedEvent(
                                                                                        response: product[i],
                                                                                        type: "screen",
                                                                                        index: i,
                                                                                        isButtonPressed: true,
                                                                                      ),
                                                                                    );
                                                                              },
                                                                              child: Container(
                                                                                height: 30,
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
                                                                              height: 30,
                                                                              decoration: BoxDecoration(
                                                                                color: appColor,
                                                                                border: Border.all(
                                                                                  color: appColor,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(
                                                                                  20,
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            HomeBloc
                                                                                          >()
                                                                                          .add(
                                                                                            RemoveItemButtonClikedEvent(
                                                                                              response: product[i],
                                                                                              type: "screen",
                                                                                              index: i,
                                                                                              isButtonPressed: true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: const Icon(
                                                                                      Icons.remove,
                                                                                      color: Colors.white,
                                                                                      size: 16,
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                          left: 8,
                                                                                          right: 8,
                                                                                        ),
                                                                                        child: Text(
                                                                                          product[i].variants![0].cartQuantity.toString(),
                                                                                          textAlign: TextAlign.center,
                                                                                          style: GoogleFonts.poppins(
                                                                                            color: appColor,
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      context
                                                                                          .read<
                                                                                            HomeBloc
                                                                                          >()
                                                                                          .add(
                                                                                            AddButtonClikedEvent(
                                                                                              response: product[i],
                                                                                              type: "screen",
                                                                                              index: i,
                                                                                              isButtonPressed: true,
                                                                                            ),
                                                                                          );
                                                                                    },
                                                                                    child: const Icon(
                                                                                      Icons.add,
                                                                                      color: Colors.white,
                                                                                      size: 16,
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
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          ],
                        ),
                      ),
                      //  SizedBox(height: 200),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
