import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(int val) => emit(val);

  void decrement(int val) {
    emit(max(state - val, 0));
  }
}
