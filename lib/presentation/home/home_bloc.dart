import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/addaddress/lat_long_get_address_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_error_response_model.dart';
import 'package:sodakkuapp/model/cart/cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_model.dart';
import 'package:sodakkuapp/model/category/add_item_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_cart_response_model.dart';
import 'package:sodakkuapp/model/category/remove_item_cart_model.dart';
import 'package:sodakkuapp/model/home/dynamic_product_style_response_model.dart';
import 'package:sodakkuapp/presentation/category/category_event.dart';
import 'package:sodakkuapp/presentation/category/category_state.dart';
import 'package:sodakkuapp/model/category/main_category_model.dart';
import 'package:sodakkuapp/model/category/product_style_model.dart';
import 'package:sodakkuapp/model/home/banner_model.dart';
import 'package:sodakkuapp/model/home/grab_essentials_model.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetLocationEvent>(getlocation);
    on<GetScreenEvent>(onTap);
    on<GrabAndGoEvent>(getGrabandGo);
    on<GetBannerEvent>(getBanner);
    on<GetOrganicFruitsEvent>(getOrganicFreshFruitsData);
    on<GetGroceryEssentialsEvent>(getGroceryEssentialsData);
    on<GetNutsDriedFruitsEvent>(getNutsDriedFruitsData);
    on<GetRiceCerealsEvent>(getRiceCerelasData);
    on<ContinueLocationEvent>(locationContinue);
    on<UpdateLocationEvent>(updateLocation);
    on<AddItemInCartApiEvent>(addItemToCart);
    on<AddButtonClikedEvent>(onAddbuttonclicked);
    on<RemoveItemInCartApiEvent>(removeItemsToCartApifunction);
    on<RemoveItemButtonClikedEvent>(onRemoveItembuttonclicked);
    on<GetCartCountEvent>(getCartCount);
    on<GetDynamicHomeProductEvent>(getDynamicHomeProductData);
    on<ShowBottomSheetEvent>((event, emit) => emit(BottomSheetVisible()));
  }

  getCartCount(GetCartCountEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      String url = "$cartUrl${event.userId}";
      debugPrint(url);
      String? token = await TokenService.getToken();
      debugPrint(token);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        var cartResponse = cartResponseFromJson(response.body);
        cartResponse.items!.length;
        int countvalue = 0;
        for (int i = 0; i < cartResponse.items!.length; i++) {
          countvalue = countvalue + cartResponse.items![i].quantity!;
        }
        emit(CartDataSuccess(noOfItems: countvalue));
      } else {
        var errorResponse = cartErrorResponseFromJson(response.body);
        emit(HomeErrorState(message: errorResponse.message ?? ""));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onAddbuttonclicked(AddButtonClikedEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(
      AddButtonClickedState(
        response: event.response,
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  addItemToCart(AddItemInCartApiEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    debugPrint('${event.quantity} - cart quantity');
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
        addCartUrl,
        addItemToCartRequestToJson(addItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var addItemToCartResponse = addItemToCartResponseFromJson(
          response.resBody,
        );
        emit(
          ItemAddedToCartInHomeScreenState(
            addItemToCartResponse: addItemToCartResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: response.resBody));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  removeItemsToCartApifunction(
    RemoveItemInCartApiEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    RemoveItemToCartRequest removeItemToCartRequest = RemoveItemToCartRequest();
    removeItemToCartRequest.userId = event.userId;
    removeItemToCartRequest.productId = event.productId;
    removeItemToCartRequest.variantLabel = event.variantLabel;
    removeItemToCartRequest.quantity = event.quantity;
    removeItemToCartRequest.handlingCharges = event.handlingCharges;
    removeItemToCartRequest.deliveryTip = event.deliveryTip;
    try {
      String url = removeCartUrl;
      debugPrint(url);
      api.Response response = await api.ApiService().postRequest(
        url,
        removeItemToCartRequestToJson(removeItemToCartRequest),
      );
      if (response.statusCode == 200) {
        var removeCartResponse = removeCartResponseFromJson(response.resBody);
        emit(ItemRemovedToCartState(removeCartResponse: removeCartResponse));
      } else {
        emit(HomeErrorState(message: response.resBody));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onRemoveItembuttonclicked(
    RemoveItemButtonClikedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoadingState());
    emit(
      RemoveButtonClickedState(
        response: event.response,
        type: event.type,
        selectedIndexes: event.index,
        isSelected: event.isButtonPressed,
      ),
    );
  }

  updateLocation(UpdateLocationEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(UpdateLocationState(location: event.location));
  }

  getOrganicFreshFruitsData(
    GetOrganicFruitsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?category_id=${event.mainCatId}&subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var organicFreshFruitsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          OrganicFreshFruitsLoadedState(
            productStyleResponse: organicFreshFruitsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getGroceryEssentialsData(
    GetGroceryEssentialsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";

      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var groceryEssentialsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          GroceryEssentialsLoadedState(
            productStyleResponse: groceryEssentialsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getNutsDriedFruitsData(
    GetNutsDriedFruitsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var nutsDriedFruitsResponse = productStyleResponseFromJson(
          response.body,
        );
        emit(
          NutsDriedFruitsLoadedState(
            productStyleResponse: nutsDriedFruitsResponse,
          ),
        );
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getRiceCerelasData(GetRiceCerealsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      String url =
          "$productUrl?category_id=${event.mainCatId}&subCategoryId=${event.subCatId}&mobileNumber=${event.mobileNo}";
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var riceCerealsResponse = productStyleResponseFromJson(response.body);
        emit(RiceCerealsLoadedState(productStyleResponse: riceCerealsResponse));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getDynamicHomeProductData(
    GetDynamicHomeProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      String url = "$baseUrl/homeProduct/list?mobileNumber=$phoneNumber";
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var riceCerealsResponse = dynamicProductStyleResponseFromJson(
          response.body,
        );
        debugPrint(response.body);
        emit(DynamicProductStyleResponseState(products: riceCerealsResponse));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  onTap(GetScreenEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(NavigateState(cartcount: event.cartcount, index: event.index));
  }

  getlocation(GetLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    String? place;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    // if (placemarks.isNotEmpty) {
    //   place = placemarks.first.subLocality;
    //   // debugPrint(
    //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
    // }
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        debugPrint("data:");
        debugPrint(result.results?.first.formattedAddress);
        // emit(LatLongAddressSuccessState(latLongLocationResponse: result));
        place =
            "${result.results![0].addressComponents![1].shortName} - ${result.results![0].addressComponents![3].shortName}";
        // if (placemarks.isNotEmpty) {
        //   place =
        //       "${placemarks.first.subLocality ?? ''} - ${placemarks.first.locality ?? ''}";
        //   // debugPrint(
        //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
        // }
        emit(
          LocationSuccessState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            place: place,
          ),
        );
        debugPrint(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
        );
      } else {
        emit(HomeErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
    // emit(LocationSuccessState(
    //     latitude: position.latitude.toString(),
    //     longitude: position.longitude.toString(),
    //     place: place));
    debugPrint(
      "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
    );
    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  locationContinue(ContinueLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    String? place;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      debugPrint("Location services are disabled.");
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // locationMessage = "Location permission denied.";
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint(
        "Location permission permanently denied. Enable from settings.",
      );
      // locationMessage =
      //     "Location permission permanently denied. Enable from settings.";
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAKVumkjaEhGUefBCclE23rivFqPK3LDRQ";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = latLongLocationResponseFromJson(response.body);
        debugPrint("data:");
        debugPrint(result.results?.first.formattedAddress);
        // emit(LatLongAddressSuccessState(latLongLocationResponse: result));
        place =
            "${result.results![0].addressComponents![1].shortName} - ${result.results![0].addressComponents![3].shortName}";
        // if (placemarks.isNotEmpty) {
        //   place =
        //       "${placemarks.first.subLocality ?? ''} - ${placemarks.first.locality ?? ''}";
        //   // debugPrint(
        //   //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
        // }
        emit(
          LocationContinueSuccessState(
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            place: place,
          ),
        );
        debugPrint(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
        );
      } else {
        emit(HomeErrorState(message: "Failed to fetch data"));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }

    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
  }

  getGrabandGo(GrabAndGoEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(grabEssaentialsUrl));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        var grabandessentials = grabandEssentialFromJson(response.body);
        emit(GrabandEssentialsLoadedState(grabandEssential: grabandessentials));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getBanner(GetBannerEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(bannerUrl));
      if (response.statusCode == 200) {
        var banners = bannerFromJson(response.body);
        emit(BannerLoadedState(banners: banners));
      } else {
        emit(HomeErrorState(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  getMainCategoryData(
    GetMainCategoryDataEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      final client = await createPinnedHttpClient();
      final response = await client.get(Uri.parse(categoryUrl));
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
}
