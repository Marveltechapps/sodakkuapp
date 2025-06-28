import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/home/search_response_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class CloseState extends SearchState {}

class VarientChangedState extends SearchState {
  final int productIndex;
  final int varientIndex;

  VarientChangedState({required this.productIndex, required this.varientIndex});
}

class AddButtonClickedState extends SearchState {
  final String type;
  final int index;

  AddButtonClickedState({required this.type, required this.index});
}

class AddedItemToCartState extends SearchState {
  final AddItemToCartResponse addItemToCartResponse;

  AddedItemToCartState({required this.addItemToCartResponse});
}

class RemoveButtonClickedState extends SearchState {
  final String type;
  final int index;

  RemoveButtonClickedState({required this.type, required this.index});
}

class ItemRemovedCartState extends SearchState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedCartState({required this.removeCartResponse});
}

class SearchSuccessState extends SearchState {
  final SearchResponse searchResults;

  SearchSuccessState({required this.searchResults});
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState({required this.errorMessage});
}
