part of 'one_category_cubit.dart';

sealed class OneCategoryState {}

final class OneCategoryInitial extends OneCategoryState {}

final class OneCategoryLoadingState extends OneCategoryState {}

final class OneCategorySuccessState extends OneCategoryState {}

final class OneCategoryFailureState extends OneCategoryState {

  final String errorMessage;

  OneCategoryFailureState({required this.errorMessage});
}
