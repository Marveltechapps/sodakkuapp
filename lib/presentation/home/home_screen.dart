import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sodakkuapp/presentation/cart/cart_screen.dart';
import 'package:sodakkuapp/presentation/home/cart_increment_cubit.dart';
import 'package:sodakkuapp/presentation/home/home_bloc.dart';
import 'package:sodakkuapp/presentation/home/home_event.dart';
import 'package:sodakkuapp/presentation/home/home_state.dart';
import 'package:sodakkuapp/presentation/category/categories_screen.dart';
import 'package:sodakkuapp/presentation/home/home_widget.dart';
import 'package:sodakkuapp/presentation/search/search_screen.dart';
import 'package:sodakkuapp/presentation/widgets/platform.dart';
import 'package:sodakkuapp/utils/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String location = "No Location Found";
  static TextEditingController searchController = TextEditingController();

  static List<Widget> screens = [
    HomeWidgetScreen(),
    CategoriesScreen(),
    SizedBox(),
    // CartScreen()
  ];

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure you want to exit?",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("No", style: TextStyle(color: appColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor, // Button background color
                foregroundColor: whitecolor, // Text (and icon) color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                moveAppToBackground(); // Properly background the app
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CounterCubit()),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is NavigateState) {
            selectedIndex = state.index;
            //  context.read<CounterCubit>().decrement(noOfIteminCart);
            context.read<CounterCubit>().increment(noOfIteminCart);
            noOfIteminCart = noOfIteminCart;
          } else if (state is CartDataSuccess) {
            // context.read<CounterCubit>().decrement(state.noOfItems);
            context.read<CounterCubit>().increment(state.noOfItems);
            noOfIteminCart = state.noOfItems;
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            debugPrint("Home Initial State");
            context.read<HomeBloc>().add(GetCartCountEvent(userId: userId));
            context.read<CounterCubit>().increment(cartCount);
            noOfIteminCart = cartCount;
          }
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (selectedIndex == 1) {
                context.read<HomeBloc>().add(
                  GetScreenEvent(cartcount: cartCount, index: 0),
                );
              } else {
                if (!didPop) {
                  showLogoutDialog(context);
                }
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFFAFAFA),
              appBar: selectedIndex == 1 || selectedIndex == 2
                  ? AppBar(
                      backgroundColor: headerColor,
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(
                            GetScreenEvent(cartcount: cartCount, index: 0),
                          );
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
                          icon: Icon(
                            Icons.search,
                            size: 23,
                            color: headerComponentsColor,
                          ),
                        ),
                      ],
                      elevation: headerElevation,
                      title: selectedIndex == 1
                          ? Text(
                              "All Categories",
                              style: TextStyle(color: headerComponentsColor),
                            )
                          : Text(
                              "Cart",
                              style: TextStyle(color: headerComponentsColor),
                            ),
                    )
                  : null,
              body: screens[selectedIndex],

              //  BlocProvider.value(
              //             value: productDetailBloc,
              //             child: StatefulBuilder(builder: (context, setState) {
              //               return BlocBuilder<ProductDetailBloc, ProductDetailState>(
              //                 builder: (context, state) {
              //                   return StatefulBuilder(builder: (context, setState) {
              bottomNavigationBar: BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  //   count = noOfIteminCart;
                  return BottomAppBar(
                    color: Colors.white,
                    shape: CircularNotchedRectangle(),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Button
                          GestureDetector(
                            onTap: () {
                              context.read<HomeBloc>().add(
                                GetScreenEvent(cartcount: cartCount, index: 0),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 0 ? homessvg : homesvg,
                                  colorFilter: ColorFilter.mode(
                                    appColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                // Icon(Icons.home, color: Colors.green, size: 30),
                                Text(
                                  "Selorg",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: selectedIndex == 0
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Categories Button
                          GestureDetector(
                            onTap: () {
                              context.read<HomeBloc>().add(
                                GetScreenEvent(cartcount: cartCount, index: 1),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 1
                                      ? categoryssvg
                                      : categorysvg,
                                  colorFilter: ColorFilter.mode(
                                    appColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: selectedIndex == 1
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Cart Button with Badge
                          GestureDetector(
                            onTap: () {
                              // context.read<HomeBloc>().add(GetScreenEvent(index: 2));
                              //   Navigator.pushNamed(context, "/cart");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CartScreen(fromScreen: 'home');
                                  },
                                ),
                              ).then((value) {
                                debugPrint("*************");
                                if (!context.mounted) return;
                                context.read<HomeBloc>().add(
                                  GetCartCountEvent(userId: userId),
                                );

                                context.read<CounterCubit>().increment(
                                  cartCount,
                                );
                                noOfIteminCart = cartCount;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    SvgPicture.asset(
                                      selectedIndex == 2 ? cartssvg : cartsvg,
                                      colorFilter: ColorFilter.mode(
                                        appColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    count == 0
                                        ? SizedBox()
                                        : Positioned(
                                            right: 0,
                                            top: -2,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: appColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                count.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Text(
                                  "Cart",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: selectedIndex == 2
                                        ? FontWeight.bold
                                        : null,
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
          );
        },
      ),
    );
  }
}
