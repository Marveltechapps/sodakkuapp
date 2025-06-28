import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/category/dynamic_category_model.dart';
import 'package:sodakkuapp/presentation/category/category_event.dart';
import 'package:sodakkuapp/presentation/category/category_state.dart';
import 'package:sodakkuapp/model/category/category_model.dart' as cat;
import 'package:sodakkuapp/model/category/main_category_model.dart';
import 'package:sodakkuapp/utils/constant.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<GetMainCategoryDataEvent>(getMainCategoryData);
    on<GetCategoryDataEvent>(getCategoryData);
    on<GetDynamicCategoryDataEvent>(getDynamicCategoryData);
  }

  getMainCategoryData(
    GetMainCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      debugPrint('function 1 works');
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(categoryUrl));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var mainCategories = mainCategoryFromJson(response.body);
        emit(MainCategoryLoadedState(mainCategory: mainCategories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }

  getCategoryData(
    GetCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      debugPrint('function 1 works');

      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final List<cat.Category> categories = cat.categoryFromJson(
          response.body,
        );
        emit(CategoryLoadedState(categories: categories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }

  getDynamicCategoryData(
    GetDynamicCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final DynamicCategories categories = dynamicCategoriesFromJson(
          response.body,
        );
        emit(DynamicCategoryLoadedState(categories: categories));
      } else {
        emit(CategoryErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CategoryErrorState(message: e.toString()));
    }
  }
}
