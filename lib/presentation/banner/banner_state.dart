import 'package:sodakkuapp/model/banner/banner_product_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class PraductSuccessState extends BannerState {
  final BannerProductResponse bannerProductResponse;

  PraductSuccessState({required this.bannerProductResponse});
}

class VarientChangedState extends BannerState {
  final int productIndex;
  final int varientIndex;

  VarientChangedState({required this.productIndex, required this.varientIndex});
}

class AddButtonPressedState extends BannerState {
  final int index;
  final int varientindex;
  final String type;

  AddButtonPressedState({
    required this.index,
    required this.varientindex,
    required this.type,
  });
}

class AddedToCartState extends BannerState {
  final AddItemToCartResponse addItemToCartResponse;

  AddedToCartState({required this.addItemToCartResponse});
}

class RemoveButtonPressedState extends BannerState {
  final int index;
  final int varientindex;
  final String type;

  RemoveButtonPressedState({
    required this.index,
    required this.varientindex,
    required this.type,
  });
}

class RemoveItemFromCartState extends BannerState {
  final RemoveCartResponse removeCartResponse;

  RemoveItemFromCartState({required this.removeCartResponse});
}

class CartCountLengthOnBannerSuccessState extends BannerState {
  final CartResponse cartResponse;

  CartCountLengthOnBannerSuccessState({required this.cartResponse});
}

class BannerErrorState extends BannerState {
  final String errorMsg;

  BannerErrorState({required this.errorMsg});
}
