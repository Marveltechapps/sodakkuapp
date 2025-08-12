import 'package:sodakkuapp/model/addaddress/add_address_save_response_mode.dart';

abstract class AddAddressState {}

class AddAddressInitialState extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressTypeingState extends AddAddressState {
  final String screenType;

  AddAddressTypeingState({required this.screenType});
}

class AddAddressSaveSuccess extends AddAddressState {
  final AddAddressSaveResponse addAddressSaveResponse;

  AddAddressSaveSuccess({required this.addAddressSaveResponse});
}

class SelectedLabelState extends AddAddressState {
  final String label;

  SelectedLabelState({required this.label});
}

class AddAddressErrorState extends AddAddressState {
  final String errorMsg;

  AddAddressErrorState({required this.errorMsg});
}
