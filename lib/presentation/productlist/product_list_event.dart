abstract class ProductListEvent {}

class OnScrollEvent extends ProductListEvent {}

class OnSelectEvent extends ProductListEvent {
  final int index;
  final String name;

  OnSelectEvent({required this.index, required this.name});
}

class CartLengthEvent extends ProductListEvent {
  final String userId;

  CartLengthEvent({required this.userId});
}

class GetSubCategoryEvent extends ProductListEvent {
  final bool isMainCategory;
  final String mainCatId;
  final bool isCat;
  final String catId;
  final String mobileNo;
  final String userId;

  GetSubCategoryEvent(
      {required this.isMainCategory,
      required this.mainCatId,
      required this.isCat,
      required this.catId,
      required this.mobileNo,
      required this.userId});
}

class ProductStyleEvent extends ProductListEvent {
  final String mobilNo;
  final String userId;
  final bool isMainCategory;
  final String mainCatId;
  final bool isSubCategory;
  final String subCatId;
  final int page;

  ProductStyleEvent(
      {required this.mobilNo,
      required this.userId,
      required this.isMainCategory,
      required this.mainCatId,
      required this.isSubCategory,
      required this.subCatId,
      required this.page});
}

class AddItemInCartApiEvent extends ProductListEvent {
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

class RemoveItemInCartApiEvent extends ProductListEvent {
  final String userId;
  final String productId;
  final String variantLabel;
  final int quantity;
  final int deliveryTip;
  final int handlingCharges;

  RemoveItemInCartApiEvent(
      {required this.userId,
      required this.productId,
      required this.variantLabel,
      required this.quantity,
      required this.deliveryTip,
      required this.handlingCharges});
}

class GetProductDetailEvent extends ProductListEvent {
  final String mobileNo;
  final String productId;

  GetProductDetailEvent({required this.mobileNo, required this.productId});
}

class ChangeVarientItemEvent extends ProductListEvent {
  final int productIndex;
  final int varientIndex;

  ChangeVarientItemEvent(
      {required this.productIndex, required this.varientIndex});
}

class AddButtonClikedEvent extends ProductListEvent {
  final String type;
  final bool isButtonPressed;
  final int index;

  AddButtonClikedEvent(
      {required this.type, required this.isButtonPressed, required this.index});
}

class RemoveItemButtonClikedEvent extends ProductListEvent {
  final String type;
  final bool isButtonPressed;
  final int index;
  final int variantIndex;

  RemoveItemButtonClikedEvent(
      {required this.type, required this.isButtonPressed, required this.index , required this.variantIndex});
}
