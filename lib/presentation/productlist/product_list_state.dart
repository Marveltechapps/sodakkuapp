import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/product_detail_model.dart';
import 'package:sodakkuapp/model/category/product_style_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/sub_category_model.dart' as sub;

abstract class ProductListState {}

class ProductInitialState extends ProductListState {}

class ProductLoadingState extends ProductListState {}

class OnScrollSuccessState extends ProductListState {
  final int page;

  OnScrollSuccessState({required this.page});
}

class VarientChangedState extends ProductListState {
  final int productIndex;
  final int varientIndex;

  VarientChangedState({required this.productIndex, required this.varientIndex});
}

class ProductSelectedState extends ProductListState {
  final int index;
  final String name;

  ProductSelectedState({required this.index, required this.name});
}

class SubCategoryLoadedState extends ProductListState {
  final sub.SubCategory subCategory;

  SubCategoryLoadedState({required this.subCategory});
}

class ProductStyleLoadedState extends ProductListState {
  final ProductStyleResponse productStyleResponse;

  ProductStyleLoadedState({required this.productStyleResponse});
}

class CartCountSuccessState extends ProductListState {
  final CartResponse cartResponse;

  CartCountSuccessState({required this.cartResponse});
}

class AddButtonClickedState extends ProductListState {
  String type;
  int selectedIndexes;
  bool isSelected;
  AddButtonClickedState({
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class ItemAddedToCartState extends ProductListState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartState({required this.addItemToCartResponse});
}

class ItemRemovedToCartState extends ProductListState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class RemoveButtonClickedState extends ProductListState {
  String type;
  int selectedIndexes;
  bool isSelected;
  RemoveButtonClickedState({
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class ProductDataState extends ProductListState {}

class ProductDetailSuccessState extends ProductListState {
  final ProductDetailResponse productDetailResponse;

  ProductDetailSuccessState({required this.productDetailResponse});
}

class AddToCartErrorState extends ProductListState {
  final String message;

  AddToCartErrorState({required this.message});
}

class ProductErrorState extends ProductListState {
  final String message;

  ProductErrorState({required this.message});
}
