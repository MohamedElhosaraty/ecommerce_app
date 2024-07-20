part of 'category_details_cubit.dart';

sealed class CategoryDetailsState {}

final class CategoryDetailsInitial extends CategoryDetailsState {}

final class CategoryDetailsLoadingState extends CategoryDetailsState {}

final class CategoryDetailsSuccessState extends CategoryDetailsState {}

final class CategoryDetailsFailureState extends CategoryDetailsState {

  final String errorMessage;

  CategoryDetailsFailureState({required this.errorMessage});
}
