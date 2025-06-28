abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class ReviewSelectedState extends OrderState {
  final bool isReviewSelected;
  final bool isReviewSubmitted;

  ReviewSelectedState({required this.isReviewSelected, required this.isReviewSubmitted});
}

class SelectOptionState extends OrderState {
  final bool isSelected;
  final int index;

  SelectOptionState({required this.isSelected, required this.index});
}
class RatingSelectedState extends OrderState {
  final double rating;

  RatingSelectedState({required this.rating});
}

class OrderErrorState extends OrderState {
  final String errorMsg;

  OrderErrorState({required this.errorMsg});
}
