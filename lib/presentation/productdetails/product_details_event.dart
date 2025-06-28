abstract class ProductDetailEvent {}

class GetProductDetailEvent extends ProductDetailEvent {
  final String mobileNo;
  final String productId;

  GetProductDetailEvent({required this.mobileNo, required this.productId});
}

class GetSimilarProductEvent extends ProductDetailEvent {
  final String productId;

  GetSimilarProductEvent({required this.productId});
}

class GetSimilarProductDetailEvent extends ProductDetailEvent {
  final String productId;

  GetSimilarProductDetailEvent({required this.productId});
}

class UpdateSimilarIndexEvent extends ProductDetailEvent {
  final int index;
  final int similarIndex;

  UpdateSimilarIndexEvent({required this.index, required this.similarIndex});
}

class GetCartCountLengthEvent extends ProductDetailEvent {
  final String userId;

  GetCartCountLengthEvent({required this.userId});
}

class AddItemInCartApiEvent extends ProductDetailEvent {
  final String userId;
  final String productId;
  final int quantity;
  final String variantLabel;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String deliveryInstructions;
  final String addNotes;

  AddItemInCartApiEvent(
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

class RemoveItemInCartApiEvent extends ProductDetailEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int handlingcharges;
  final int deliveryTip;

  RemoveItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.variantLabel,
      required this.quantity,
      required this.handlingcharges,
      required this.deliveryTip});
}

class LabelVarientItemEvent extends ProductDetailEvent {
  final int productIndex;
  final int varientIndex;

  LabelVarientItemEvent(
      {required this.productIndex, required this.varientIndex});
}

class AddButtonClikedEvent extends ProductDetailEvent {
  final String type;
  final bool isButtonPressed;
  final int index;
  final int similarIndex;

  AddButtonClikedEvent(
      {required this.type,
      required this.isButtonPressed,
      required this.index,
      required this.similarIndex});
}

class RemoveItemButtonClikedEvent extends ProductDetailEvent {
  final String type;
  final bool isButtonPressed;
  final int index;
  final int similarIndex;

  RemoveItemButtonClikedEvent(
      {required this.type,
      required this.isButtonPressed,
      required this.index,
      required this.similarIndex});
}
