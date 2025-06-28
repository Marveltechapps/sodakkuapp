import 'package:sodakkuapp/model/addaddress/delete_address_response_model.dart';
import 'package:sodakkuapp/model/addaddress/get_saved_address_response_model.dart';

abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddressLoadingState extends AddressState {}

class AddressSuccessState extends AddressState {
  final GetSavedAddressResponse getSavedAddressResponse;

  AddressSuccessState({required this.getSavedAddressResponse});
}

class AddressDeletedSuccessState extends AddressState {
  final DeleteAddressResponse deleteAddressResponse;

  AddressDeletedSuccessState({required this.deleteAddressResponse});
}

class AddressErrorState extends AddressState {
  final String errorMsg;

  AddressErrorState({required this.errorMsg});
}
