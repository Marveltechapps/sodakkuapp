import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/product_style_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/home/banner_model.dart';
import 'package:sodakkuapp/model/home/dynamic_product_style_response_model.dart';
import 'package:sodakkuapp/model/home/grab_essentials_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeDummyState extends HomeState {}

class HomeLoadingState extends HomeState {}

class UpdateLocationState extends HomeState {
  final String location;

  UpdateLocationState({required this.location});
}

class AddButtonClickedState extends HomeState {
  Product response;
  String type;
  int selectedIndexes;
  bool isSelected;
  AddButtonClickedState({
    required this.response,
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class CartDataSuccess extends HomeState {
  final int noOfItems;

  CartDataSuccess({required this.noOfItems});
}

class NavigateState extends HomeState {
  final int cartcount;
  final int index;

  NavigateState({required this.cartcount, required this.index});
}

class LocationSuccessState extends HomeState {
  String? latitude;
  String? longitude;
  String? place;

  LocationSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}

class LocationContinueSuccessState extends HomeState {
  String? latitude;
  String? longitude;
  String? place;

  LocationContinueSuccessState({
    required this.latitude,
    required this.longitude,
    required this.place,
  });
}

class BottomSheetVisible extends HomeState {}

class RemoveButtonClickedState extends HomeState {
  Product response;
  String type;
  int selectedIndexes;
  bool isSelected;
  RemoveButtonClickedState({
    required this.response,
    required this.type,
    required this.selectedIndexes,
    required this.isSelected,
  });
}

class ItemRemovedToCartState extends HomeState {
  final RemoveCartResponse removeCartResponse;

  ItemRemovedToCartState({required this.removeCartResponse});
}

class OrganicFreshFruitsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  OrganicFreshFruitsLoadedState({required this.productStyleResponse});
}

class ItemAddedToCartInHomeScreenState extends HomeState {
  final AddItemToCartResponse addItemToCartResponse;

  ItemAddedToCartInHomeScreenState({required this.addItemToCartResponse});
}

class GroceryEssentialsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  GroceryEssentialsLoadedState({required this.productStyleResponse});
}

class NutsDriedFruitsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  NutsDriedFruitsLoadedState({required this.productStyleResponse});
}

class RiceCerealsLoadedState extends HomeState {
  final ProductStyleResponse productStyleResponse;

  RiceCerealsLoadedState({required this.productStyleResponse});
}

class GrabandEssentialsLoadedState extends HomeState {
  final GrabandEssential grabandEssential;

  GrabandEssentialsLoadedState({required this.grabandEssential});
}

class DynamicProductStyleResponseState extends HomeState {
  final DynamicProductStyleResponse products;

  DynamicProductStyleResponseState({required this.products});
}

class BannerLoadedState extends HomeState {
  final Banner banners;

  BannerLoadedState({required this.banners});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
