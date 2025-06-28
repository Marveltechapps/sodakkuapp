import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/settings/order/order_event.dart';
import 'package:sodakkuapp/presentation/settings/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitialState()) {
    on<AddReviewEvent>(onClickedfunction);
    on<RatingEvent>(onRatingfunction);
    on<SelectOptionEvent>(onSelectOptionfunction);
  }

  onSelectOptionfunction(SelectOptionEvent event, Emitter<OrderState> emit) {
    emit(OrderLoadingState());
    emit(SelectOptionState(isSelected: event.isSelected, index: event.index));
  }

  onClickedfunction(AddReviewEvent event, Emitter<OrderState> emit) {
    emit(OrderLoadingState());
    emit(
      ReviewSelectedState(
        isReviewSelected: event.isReviewSelected,
        isReviewSubmitted: event.isReviewSubmitted,
      ),
    );
  }

  onRatingfunction(RatingEvent event, Emitter<OrderState> emit) {
    emit(OrderLoadingState());
    emit(RatingSelectedState(rating: event.rating));
  }
}
