import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/product_detail_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/similar_product_detail_response_model.dart';
import 'package:sodakkuapp/model/category/similar_product_response_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailSuccessState extends ProductDetailState {
  final ProductDetailResponse productDetailResponse;

  ProductDetailSuccessState({required this.productDetailResponse});
}

class CartCountLengthSuccessState extends ProductDetailState {
  final CartResponse cartResponse;

  CartCountLengthSuccessState({required this.cartResponse});
}

class SimilarProductSuccessState extends ProductDetailState {
  final SimilarProductResponse similarProductResponse;

  SimilarProductSuccessState({required this.similarProductResponse});
}

class UpdateSimilarProductIndexState extends ProductDetailState {
  final int index;
  final int similarIndex;

  UpdateSimilarProductIndexState({
    required this.index,
    required this.similarIndex,
  });
}

class SimilarProductDetailSuccessState extends ProductDetailState {
  final SimilarProductDetailResponse similarProductDetailResponse;

  SimilarProductDetailSuccessState({
    required this.similarProductDetailResponse,
  });
}

class LabelChangedState extends ProductDetailState {
  final int productIndex;
  final int varientIndex;

  LabelChangedState({required this.productIndex, required this.varientIndex});
}

class AddButtonClickedState extends ProductDetailState {
  String type;
  int selectedIndexes;
  int similarIndex;
  bool isSelected;
  AddButtonClickedState({
    required this.type,
    required this.selectedIndexes,
    required this.similarIndex,
    required this.isSelected,
  });
}

class ItemAddedToCartState extends ProductDetailState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartState({required this.addItemToCartResponse});
}

class ItemRemovedToCartState extends ProductDetailState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class RemoveButtonClickedState extends ProductDetailState {
  String type;
  int selectedIndexes;
  bool isSelected;
  int similarIndex;
  RemoveButtonClickedState({
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
    required this.similarIndex,
  });
}

class ProductDetailErrorState extends ProductDetailState {
  final String errorMsg;

  ProductDetailErrorState({required this.errorMsg});
}
