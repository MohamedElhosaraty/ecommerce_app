part of 'carts_cubit.dart';

sealed class CartsState {}

final class CartsInitial extends CartsState {}

final class CartsLoadingState extends CartsState {}

final class CartsSuccessState extends CartsState {}

final class CartsFailureState extends CartsState {
  final String errorMessage;

  CartsFailureState({required this.errorMessage});
}

final class ChangeCartsLoadingState extends CartsState {}

final class ChangeCartsSuccessState extends CartsState {}

final class ChangeCartsFailureState extends CartsState {
  final String errorMessage;

  ChangeCartsFailureState({required this.errorMessage});
}
