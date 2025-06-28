abstract class CartEvent {}

class GetCartDetailsEvent extends CartEvent {
  final String userId;

  GetCartDetailsEvent({required this.userId});
}

class PlaceAddressEvent extends CartEvent {
  final String locationType;
  final String address;

  PlaceAddressEvent({required this.locationType, required this.address});
}

class UpdateDeliveryTip extends CartEvent {
  final String userid;
  final String tip;

  UpdateDeliveryTip({required this.userid, required this.tip});
}

class UpdateCartDataEvent extends CartEvent {
  final String userId;
  final String deliveryInstructions;
  final String addNotes;
  final String deliveryTip;
  final String deliveryFee;

  UpdateCartDataEvent(
      {required this.userId,
      required this.deliveryInstructions,
      required this.addNotes,
      required this.deliveryTip,
      required this.deliveryFee});
}

class FetchAddressEvent extends CartEvent {
  final String locationType;
  final String address;

  FetchAddressEvent({required this.locationType, required this.address});
}

class GetSavedAddressFromApiEvent extends CartEvent {
  final String time;
  final String userId;

  GetSavedAddressFromApiEvent({required this.time, required this.userId});
}

class AddButtonClikedEvent extends CartEvent {
  final int selectedIndex;

  AddButtonClikedEvent({required this.selectedIndex});
}

class RemoveItemFromCartEvent extends CartEvent {
  final int selectedIndex;

  RemoveItemFromCartEvent({required this.selectedIndex});
}

class AddItemInCartApiEvent extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String delivaryInstructions;
  final String addNotes;

  AddItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.variantLabel,
      required this.imageUrl,
      required this.price,
      required this.discountPrice,
      required this.delivaryInstructions,
      required this.addNotes});
}

class RemoveItemInCartApiEvent extends CartEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final int deliveryTip;
  final int handlingCharges;

  RemoveItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.variantLabel,
      required this.deliveryTip,
      required this.handlingCharges});
}

class DeliveryInstructionSelectEvent extends CartEvent {
  final bool one;
  final bool two;

  DeliveryInstructionSelectEvent({required this.one, required this.two});
}

class PayExpandBoolEvent extends CartEvent {
  final bool isExpand;

  PayExpandBoolEvent({required this.isExpand});
}

class SelectTipEvent extends CartEvent {
  final String amount;

  SelectTipEvent({required this.amount});
}
