import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/cart/update_cart_response_model.dart';
import 'package:sodakkuapp/model/cart/update_delivery_tip_response_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class PayExpantionState extends CartState {
  final bool isExpand;

  PayExpantionState({required this.isExpand});
}

class DelivaryInstructionSelectState extends CartState {
  final bool one;
  final bool two;

  DelivaryInstructionSelectState({required this.one, required this.two});
}

class AddressFetchedSuccessState extends CartState {
  final String loctionType;
  final String address;

  AddressFetchedSuccessState({
    required this.loctionType,
    required this.address,
  });
}

class CartDataSuccess extends CartState {
  final CartResponse cartResponse;

  CartDataSuccess({required this.cartResponse});
}

class PlaceAddressState extends CartState {
  final String locationType;
  final String address;

  PlaceAddressState({required this.locationType, required this.address});
}

class AddButtonClickedState extends CartState {
  final int selectedIndex;

  AddButtonClickedState({required this.selectedIndex});
}

class RemoveButtonClickedState extends CartState {
  final int selectedIndex;

  RemoveButtonClickedState({required this.selectedIndex});
}

class ItemAddedToCartState extends CartState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartState({required this.addItemToCartResponse});
}

class ItemRemovedToCartState extends CartState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class UpdateDeliveryTipApiSuccessState extends CartState {
  final UpdateDeliveryTipResponseModel updateDeliveryTipResponseModel;

  UpdateDeliveryTipApiSuccessState({
    required this.updateDeliveryTipResponseModel,
  });
}

class SavedAddressFetchedSuccess extends CartState {
  final String time;
  final GetSavedAddressResponse getSavedAddressResponse;

  SavedAddressFetchedSuccess({
    required this.time,
    required this.getSavedAddressResponse,
  });
}

class UpdateCartStateSuccess extends CartState {
  final UpdateCartResponse updateCartResponse;

  UpdateCartStateSuccess({required this.updateCartResponse});
}

class SelectedTipState extends CartState {
  final String amount;

  SelectedTipState({required this.amount});
}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {
  final String errormsg;

  CartErrorState({required this.errormsg});
}
