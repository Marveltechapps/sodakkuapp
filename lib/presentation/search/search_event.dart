abstract class SearchEvent {}

class SearchApiEvent extends SearchEvent {
  final String searchText;

  SearchApiEvent({required this.searchText});
}

class ChangeVarientItemEvent extends SearchEvent {
  final int productIndex;
  final int varientIndex;

  ChangeVarientItemEvent(
      {required this.productIndex, required this.varientIndex});
}

class ClickCloseButtonEvent extends SearchEvent {}

class AddButtonClickedEvent extends SearchEvent {
  final String type;
  final int index;

  AddButtonClickedEvent({required this.type, required this.index});
}

class ItemAddToCartApiEvent extends SearchEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String deliveryInstructions;
  final String addNotes;

  ItemAddToCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.variantLabel,
      required this.imageUrl,
      required this.price,
      required this.discountPrice,
      required this.deliveryInstructions,
      required this.addNotes});
}

class RemoveButtonClickedEvent extends SearchEvent {
  final String type;
  final int index;

  RemoveButtonClickedEvent({required this.type, required this.index});
}

class ItemRemoveFromApiEvent extends SearchEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int deliveryTip;
  final int handlingCharges;

  ItemRemoveFromApiEvent(
      {required this.userId,
      required this.productId,
      required this.variantLabel,
      required this.quantity,
      required this.deliveryTip,
      required this.handlingCharges});
}
