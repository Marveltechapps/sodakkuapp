abstract class OrderEvent {}

class AddReviewEvent extends OrderEvent {
  final bool isReviewSelected;
  final bool isReviewSubmitted;

  AddReviewEvent({required this.isReviewSubmitted, required this.isReviewSelected});
}

class SelectOptionEvent extends OrderEvent {
  final bool isSelected;
  final int index;

  SelectOptionEvent({required this.isSelected, required this.index});
}
class RatingEvent extends OrderEvent {
  final double rating;

  RatingEvent({required this.rating});
}