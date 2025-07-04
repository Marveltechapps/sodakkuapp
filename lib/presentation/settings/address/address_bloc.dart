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
      final client = await createPinnedHttpClient();
      final response = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${await TokenService.getToken()}"},
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
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${await TokenService.getToken()}",
      };

      String url = "$deleteAddressUrl${event.id}";

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
        emit(AddressErrorState(errorMsg: response.reasonPhrase ?? ""));
      }
    } catch (e) {
      emit(AddressErrorState(errorMsg: e.toString()));
    }
  }
}
