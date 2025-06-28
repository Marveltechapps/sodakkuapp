import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/cart/update_cart_request_model.dart';
import 'package:sodakkuapp/model/cart/update_cart_response_model.dart';
import 'package:sodakkuapp/model/cart/update_delivery_tip_request_model.dart';
import 'package:sodakkuapp/model/cart/update_delivery_tip_response_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_item_cart_model.dart';
import 'package:sodakkuapp/presentation/cart/cart_event.dart';
import 'package:sodakkuapp/presentation/cart/cart_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<GetCartDetailsEvent>(getCartDetails);
    on<SelectTipEvent>(selectTipFunction);
    on<PayExpandBoolEvent>(onExpandclick);
    on<DeliveryInstructionSelectEvent>(onSelectDeliveryInstructions);
    on<FetchAddressEvent>(fetchAddress);
    on<GetSavedAddressFromApiEvent>(getSavedAddress);
    on<PlaceAddressEvent>(placeAddressValue);
    on<AddButtonClikedEvent>(onAddbuttonclicked);
    on<RemoveItemFromCartEvent>(onRemovebuttonclicked);
    on<AddItemInCartApiEvent>(addItemsToCartApifunction);
    on<RemoveItemInCartApiEvent>(removeItemsToCartApifunction);
    on<UpdateCartDataEvent>(updatecart);
    on<UpdateDeliveryTip>(updatedeliverytip);
  }

  onAddbuttonclicked(AddButtonClikedEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(AddButtonClickedState(selectedIndex: event.selectedIndex));
  }

  onRemovebuttonclicked(
    RemoveItemFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadingState());
    emit(RemoveButtonClickedState(selectedIndex: event.selectedIndex));
  }

  fetchAddress(FetchAddressEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(
      AddressFetchedSuccessState(
        loctionType: event.locationType,
        address: event.address,
      ),
    );
  }

  onSelectDeliveryInstructions(
    DeliveryInstructionSelectEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadingState());
    emit(DelivaryInstructionSelectState(one: event.one, two: event.two));
  }

  onExpandclick(PayExpandBoolEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(PayExpantionState(isExpand: event.isExpand));
  }

  selectTipFunction(SelectTipEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(SelectedTipState(amount: event.amount));
  }

  placeAddressValue(PlaceAddressEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    emit(
      PlaceAddressState(
        locationType: event.locationType,
        address: event.address,
      ),
    );
  }

  getCartDetails(GetCartDetailsEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${await TokenService.getToken()}"},
      );
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        emit(CartDataSuccess(cartResponse: cartResponse));
      } else {
        emit(CartErrorState(errormsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }

  updatedeliverytip(UpdateDeliveryTip event, Emitter<CartState> emit) async {
    emit(CartLoadingState());

    UpdateDeliveryTipRequestModel updateDeliveryTipRequestModel =
        UpdateDeliveryTipRequestModel();
    updateDeliveryTipRequestModel.userId = event.userid;
    updateDeliveryTipRequestModel.deliveryTip = int.parse(event.tip);
    try {
      String url = updateDeliveryTipUrl;
      debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        updateDeliveryTipRequestModelToJson(updateDeliveryTipRequestModel),
      );
      if (response.statusCode == 200) {
        var updateDeliveryTipResponse = updateDeliveryTipResponseModelFromJson(
          response.resBody,
        );
        emit(
          UpdateDeliveryTipApiSuccessState(
            updateDeliveryTipResponseModel: updateDeliveryTipResponse,
          ),
        );
      } else {
        emit(CartErrorState(errormsg: response.resBody));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }

  updatecart(UpdateCartDataEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    UpdateCartRequest updateCartRequest = UpdateCartRequest();
    updateCartRequest.userId = event.userId;
    updateCartRequest.deliveryInstructions = event.deliveryInstructions;
    updateCartRequest.addNotes = event.addNotes;
    updateCartRequest.deliveryTip = int.parse(
      event.deliveryTip == "" ? "0" : event.deliveryTip,
    );
    updateCartRequest.deliveryFee = int.parse(event.deliveryFee);
    try {
      String url = updateCartUrl;
      debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        updateCartRequestToJson(updateCartRequest),
      );
      if (response.statusCode == 200) {
        var res = updateCartResponseFromJson(response.resBody);
        emit(UpdateCartStateSuccess(updateCartResponse: res));
      } else {
        emit(CartErrorState(errormsg: response.resBody));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }

  addItemsToCartApifunction(
    AddItemInCartApiEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.price;
    addItemToCartRequest.deliveryInstructions = event.delivaryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      String url = addCartUrl;
      // debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        addItemToCartRequestToJson(addItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var addItemToCartResponse = addItemToCartResponseFromJson(
          response.resBody,
        );
        emit(
          ItemAddedToCartState(addItemToCartResponse: addItemToCartResponse),
        );
      } else {
        emit(CartErrorState(errormsg: response.resBody));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }

  removeItemsToCartApifunction(
    RemoveItemInCartApiEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    removeItemToCartRequest.handlingCharges = event.handlingCharges;

    try {
      String url = removeCartUrl;
      //  debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        removeItemToCartRequestToJson(removeItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var removeCartResponse = removeCartResponseFromJson(response.resBody);
        emit(ItemRemovedToCartState(removeCartResponse: removeCartResponse));
      } else {
        emit(CartErrorState(errormsg: response.resBody));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }

  getSavedAddress(
    GetSavedAddressFromApiEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    try {
      String url = "$getAddressUrl${event.userId}";
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${TokenService.getToken()}"},
      );
      if (response.statusCode == 200) {
        var getSavedAddressResponse = getSavedAddressResponseFromJson(
          response.body,
        );
        emit(
          SavedAddressFetchedSuccess(
            time: event.time,
            getSavedAddressResponse: getSavedAddressResponse,
          ),
        );
      } else {
        emit(CartErrorState(errormsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CartErrorState(errormsg: e.toString()));
    }
  }
}
