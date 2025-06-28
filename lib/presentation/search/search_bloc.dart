import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/category/add_item_cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_item_cart_model.dart';
import 'package:sodakkuapp/model/home/search_response_model.dart';
import 'package:sodakkuapp/presentation/search/search_event.dart';
import 'package:sodakkuapp/presentation/search/search_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchApiEvent>(getsearchlist);
    on<ClickCloseButtonEvent>(onCloseClicked);
    on<AddButtonClickedEvent>(onAddbuttonclicked);
    on<RemoveButtonClickedEvent>(onRemovebuttonclicked);
    on<ChangeVarientItemEvent>(changeVarientFunction);
    on<ItemAddToCartApiEvent>(addToCartApifunction);
    on<ItemRemoveFromApiEvent>(removeItemsCartApifunction);
  }

  changeVarientFunction(
    ChangeVarientItemEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchLoadingState());
    emit(
      VarientChangedState(
        productIndex: event.productIndex,
        varientIndex: event.varientIndex,
      ),
    );
  }

  onAddbuttonclicked(AddButtonClickedEvent event, Emitter<SearchState> emit) {
    emit(SearchLoadingState());
    emit(AddButtonClickedState(type: event.type, index: event.index));
  }

  addToCartApifunction(
    ItemAddToCartApiEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
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
          AddedItemToCartState(addItemToCartResponse: addItemToCartResponse),
        );
      } else {
        emit(SearchErrorState(errorMessage: response.resBody));
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }

  onRemovebuttonclicked(
    RemoveButtonClickedEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchLoadingState());
    emit(RemoveButtonClickedState(type: event.type, index: event.index));
  }

  removeItemsCartApifunction(
    ItemRemoveFromApiEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
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
        emit(ItemRemovedCartState(removeCartResponse: removeCartResponse));
      } else {
        emit(SearchErrorState(errorMessage: response.resBody));
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }

  onCloseClicked(ClickCloseButtonEvent event, Emitter<SearchState> emit) {
    emit(SearchLoadingState());
    emit(CloseState());
  }

  getsearchlist(SearchApiEvent event, Emitter<SearchState> emit) async {
    // emit(SearchLoadingState());
    try {
      String url =
          "$searchProductUrl${event.searchText}&mobileNumber=$phoneNumber";
      debugPrint(url);
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var searchResponse = searchResponseFromJson(response.body);
        emit(SearchSuccessState(searchResults: searchResponse));
      } else {
        emit(SearchErrorState(errorMessage: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
