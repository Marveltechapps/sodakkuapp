import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/apiservice/ssl_pinning_https.dart';
import 'package:sodakkuapp/model/addaddress/delete_address_response_model.dart';
import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';
import 'package:sodakkuapp/presentation/settings/address/address_event.dart';
import 'package:sodakkuapp/presentation/settings/address/address_state.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:http/http.dart' as http;

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialState()) {
    on<GetSavedAddressEvent>(getSavedAddress);
    on<DeleteSavedAddressEvent>(deleteAddress);
  }

  getSavedAddress(
    GetSavedAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    try {
      String url = "$getAddressUrl${event.userId}";
      debugPrint(url);
      String? token = await TokenService.getToken();
      debugPrint(token);
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        var getSavedAddressResponse = getSavedAddressResponseFromJson(
          response.body,
        );
        emit(
          AddressSuccessState(getSavedAddressResponse: getSavedAddressResponse),
        );
      } else {
        emit(AddressErrorState(errorMsg: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }

  deleteAddress(
    DeleteSavedAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());
    try {
      String? token = await TokenService.getToken();
      if (token == null) {
        emit(AddressErrorState(errorMsg: "Authorization token not found"));
        return;
      }

      var headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };

      String url = "$deleteAddressUrl${event.id}";
      debugPrint("Delete URL: $url");

      var request = http.Request('DELETE', Uri.parse(url));
      request.body = json.encode({
        "label": event.label,
        "details": {
          "houseNo": event.houseNo,
          "building": event.building,
          "landmark": event.landMark,
          "area": event.area,
          "city": event.city,
          "state": event.state,
          "pincode": event.pinCode,
        },
        "coordinates": {
          "latitude": event.latitude,
          "longitude": event.longitude,
        },
      });
      request.headers.addAll(headers);
      debugPrint("Request Body: ${request.body}");

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        var deleteAddressResponse = deleteAddressResponseFromJson(res);
        emit(
          AddressDeletedSuccessState(
            deleteAddressResponse: deleteAddressResponse,
          ),
        );
      } else {
        var error = await response.stream.bytesToString();
        emit(
          AddressErrorState(
            errorMsg: error.isNotEmpty
                ? error
                : response.reasonPhrase ?? "Unknown error",
          ),
        );
      }
    } catch (e) {
      debugPrint("Delete error: $e");
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }
}
