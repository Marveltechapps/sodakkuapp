import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/banner/banner_error_response.dart';
import 'package:sodakkuapp/model/banner/banner_product_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_item_cart_model.dart';
import 'package:sodakkuapp/presentation/banner/banner_event.dart';
import 'package:sodakkuapp/presentation/banner/banner_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitialState()) {
    on<GetProductDetailsEvent>(getProductDetails);
    on<AddButtonPressedEvent>(onAddPressed);
    on<RemoveButtonPressedEvent>(onRemovePressed);
    on<AddItemApiEvent>(addItemToApi);
    on<RemoveItemApiEvent>(removeItemFromCartApifunction);
    on<GetCartCountLengthOnBannerEvent>(getCartCountOnBannerfunction);
    on<ChangeVarientItemEvent>(changeVarientFunction);
  }

  changeVarientFunction(
    ChangeVarientItemEvent event,
    Emitter<BannerState> emit,
  ) {
    emit(BannerLoadingState());
    emit(
      VarientChangedState(
        productIndex: event.productIndex,
        varientIndex: event.varientIndex,
      ),
    );
  }

  onAddPressed(AddButtonPressedEvent event, Emitter<BannerState> emit) {
    emit(BannerLoadingState());
    emit(
      AddButtonPressedState(
        index: event.index,
        varientindex: event.varientindex,
        type: event.type,
      ),
    );
  }

  addItemToApi(AddItemApiEvent event, Emitter<BannerState> emit) async {
    emit(BannerLoadingState());
    AddItemToCartRequest addItemToCartRequest = AddItemToCartRequest();
    addItemToCartRequest.userId = event.userId;
    addItemToCartRequest.productId = event.productId;
    addItemToCartRequest.quantity = event.quantity;
    addItemToCartRequest.variantLabel = event.variantLabel;
    addItemToCartRequest.imageUrl = event.imageUrl;
    addItemToCartRequest.price = event.price;
    addItemToCartRequest.discountPrice = event.discountPrice;
    addItemToCartRequest.deliveryInstructions = event.deliveryInstructions;
    addItemToCartRequest.addNotes = event.addNotes;
    try {
      String url = addCartUrl;
      debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        addItemToCartRequestToJson(addItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var addItemToCartResponse = addItemToCartResponseFromJson(
          response.resBody,
        );
        emit(AddedToCartState(addItemToCartResponse: addItemToCartResponse));
      } else {
        emit(BannerErrorState(errorMsg: response.resBody));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  onRemovePressed(RemoveButtonPressedEvent event, Emitter<BannerState> emit) {
    emit(BannerLoadingState());
    emit(
      RemoveButtonPressedState(
        index: event.index,
        varientindex: event.varientindex,
        type: event.type,
      ),
    );
  }

  removeItemFromCartApifunction(
    RemoveItemApiEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.handlingCharges = event.handlingcharges;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    try {
      String url = removeCartUrl;
      //  debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        removeItemToCartRequestToJson(removeItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var removeCartResponse = removeCartResponseFromJson(response.resBody);
        emit(RemoveItemFromCartState(removeCartResponse: removeCartResponse));
      } else {
        emit(BannerErrorState(errorMsg: response.resBody));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  getCartCountOnBannerfunction(
    GetCartCountLengthOnBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    String? token = await TokenService.getToken();
    debugPrint(token);
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        emit(CartCountLengthOnBannerSuccessState(cartResponse: cartResponse));
      } else {
        emit(BannerErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }

  getProductDetails(
    GetProductDetailsEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(BannerLoadingState());
    try {
      String url =
          "$bannerProductUrl?banner_id=${event.bannerId}&mobileNumber=$phoneNumber";
      debugPrint("url: $url");
      //banner_id=677212d080a962bfdeb320e0&product_id=6793896361c4500641a079c2
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bannerProduct = bannerProductResponseFromJson(response.body);
        emit(PraductSuccessState(bannerProductResponse: bannerProduct));
      } else {
        var res = bannerProductErrorResponseFromJson(response.body);
        emit(BannerErrorState(errorMsg: res.msg ?? ""));
      }
    } catch (e) {
      emit(BannerErrorState(errorMsg: e.toString()));
    }
  }
}
