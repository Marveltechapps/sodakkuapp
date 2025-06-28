import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetMainCategoryDataEvent extends CategoryEvent {}

class GetCategoryDataEvent extends CategoryEvent {}

class GetDynamicCategoryDataEvent extends CategoryEvent {}
