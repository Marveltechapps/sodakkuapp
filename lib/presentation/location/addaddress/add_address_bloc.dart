import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/model/addaddress/add_address_save_response_mode.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_event.dart';
import 'package:sodakkuapp/presentation/location/addaddress/add_address_state.dart';
import 'package:sodakkuapp/apiservice/post_method.dart' as api;
import 'package:http/http.dart' as http;

import 'package:sodakkuapp/utils/constant.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(AddAddressInitialState()) {
    on<SaveAddressEvent>(saveAddress);
    on<SelectLabelEvent>(selectLabelFunction);
    on<UpdateAddressEvent>(updateAddress);
    on<TypeEvent>(typefunction);
  }

  typefunction(TypeEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressLoadingState());
    emit(AddAddressTypeingState());
  }

  selectLabelFunction(SelectLabelEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressLoadingState());
    emit(SelectedLabelState(label: event.label));
  }

  saveAddress(SaveAddressEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState());
    try {
      String url = saveAddressUrl;
      api.Response res = await api.ApiService().postRequest(
        url,
        jsonEncode({
          "userId": event.userId,
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
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(
          res.resBody,
        );
        emit(
          AddAddressSaveSuccess(addAddressSaveResponse: addAddressSaveResponse),
        );
      } else {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(
          res.resBody,
        );
        emit(
          AddAddressErrorState(errorMsg: addAddressSaveResponse.message ?? ""),
        );
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMsg: e.toString()));
    }
  }

  updateAddress(UpdateAddressEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressLoadingState());
    try {
      String url = "$updateAddressUrl/${event.id}";
      debugPrint(url);
      String? token = await TokenService.getToken();
      debugPrint(token);
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      };
      var request = http.Request('PUT', Uri.parse(url));
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

      var res = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        var addAddressSaveResponse = addAddressSaveResponseFromJson(res);
        emit(
          AddAddressSaveSuccess(addAddressSaveResponse: addAddressSaveResponse),
        );
      } else {
        emit(AddAddressErrorState(errorMsg: response.reasonPhrase ?? ""));
      }
    } catch (e) {
      emit(AddAddressErrorState(errorMsg: e.toString()));
    }
  }
}
