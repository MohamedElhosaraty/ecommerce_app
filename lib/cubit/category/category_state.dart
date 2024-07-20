part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoadingState extends CategoryState {}

final class CategorySuccessState extends CategoryState {}

final class CategoryFailureState extends CategoryState {

  final String errorMessage;

  CategoryFailureState({required this.errorMessage});
}