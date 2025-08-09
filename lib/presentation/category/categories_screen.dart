import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sodakkuapp/model/category/dynamic_category_model.dart';
import 'package:sodakkuapp/presentation/category/category_bloc.dart';
import 'package:sodakkuapp/presentation/category/category_event.dart';
import 'package:sodakkuapp/presentation/category/category_state.dart';
import 'package:sodakkuapp/model/category/category_model.dart' as cat;
import 'package:sodakkuapp/model/category/main_category_model.dart';
import 'package:sodakkuapp/presentation/home/home_bloc.dart';
import 'package:sodakkuapp/presentation/home/home_event.dart';
import 'package:sodakkuapp/presentation/productlist/product_list_menu.dart';
import 'package:sodakkuapp/presentation/widgets/network_image.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static List<cat.Category> categories = [];
  static MainCategory mainCategory = MainCategory();
  static DynamicCategories dynamicCategories = DynamicCategories();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is MainCategoryLoadedState) {
            debugPrint("mainCategoryLoaded");
            mainCategory = state.mainCategory;
          } else if (state is CategoryLoadedState) {
            debugPrint("CategoryLoadedState");
            categories = state.categories;
          } else if (state is DynamicCategoryLoadedState) {
            dynamicCategories = state.categories;
          } else if (state is CategoryErrorState) {
            debugPrint("CategoryErrorState");
            debugPrint(state.message);
          }
        },
        builder: (context, state) {
          if (state is CategoryInitialState) {
            debugPrint("CategoryInitialState");
            // context.read<CategoryBloc>().add(GetMainCategoryDataEvent());
            // context.read<CategoryBloc>().add(GetCategoryDataEvent());
            context.read<CategoryBloc>().add(GetDynamicCategoryDataEvent());
          }
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              debugPrint("++++++++++++++");
              context.read<HomeBloc>().add(GetDynamicHomeProductEvent());
            },
            child: OverlayLoaderWithAppIcon(
              appIconSize: 60,
              circularProgressColor: Colors.transparent,
              overlayBackgroundColor: Colors.black87,
              isLoading: state is CategoryLoadingState,
              appIcon: Image.asset(loadGif, fit: BoxFit.fill),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    spacing: 16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore by Categories',
                            style: Theme.of(context).textTheme.titleMedium,
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
                                  double screenWidth = constraints.maxWidth;
                                  double itemWidth =
                                      (screenWidth - (22 * 2)) /
                                      3; // Adjust for crossAxisSpacing
                                  double itemHeight =
                                      itemWidth *
                                      1.2; // Adjust height dynamically

                                  List<Category>? categorydata =
                                      [
                                        ...dynamicCategories
                                            .data![categoryIndex]
                                            .categories!,
                                      ]..sort(
                                        (a, b) => a.index!.compareTo(b.index!),
                                      );
                                  return StaggeredGrid.count(
                                    crossAxisCount: 48,
                                    // crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 15,
                                    children: categorydata
                                        .map(
                                          (data) => StaggeredGridTile.count(
                                            crossAxisCellCount:
                                                data.isHighlight! ? 24 : 16,
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
                                                              data.name ?? "",
                                                          id: data.id ?? "",
                                                          isMainCategory: true,
                                                          mainCatId:
                                                              data.id ?? "",
                                                          isCategory: true,
                                                          catId: data.id ?? "",
                                                        ),
                                                  ),
                                                ).then((value) {});
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
                                                              .withAlpha(120),
                                                          blurRadius: 0,
                                                          offset: const Offset(
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
                                                          fit: BoxFit.contain,
                                                          width:
                                                              itemWidth *
                                                              1.5, // Adjust image width dynamically
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  SizedBox(
                                                    width:
                                                        itemWidth *
                                                        1.1, // Ensure text fits within item width
                                                    child: Text(
                                                      data.name ?? "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color(
                                                          0xFF222222,
                                                        ),
                                                      ),
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
                            ],
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
