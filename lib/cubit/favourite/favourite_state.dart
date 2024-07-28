part of 'favourite_cubit.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoadingState extends FavouriteState {}

final class FavouriteSuccessState extends FavouriteState {}

final class FavouriteFailureState extends FavouriteState {

  final String errorMessage;

  FavouriteFailureState({required this.errorMessage});
}

final class ChangeFavouriteState extends FavouriteState {}

final class ChangeFavouriteLoadingState extends FavouriteState {}

final class ChangeFavouriteSuccessState extends FavouriteState {}

final class ChangeFavouriteFailureState extends FavouriteState {

  final String errorMessage;

  ChangeFavouriteFailureState({required this.errorMessage});
}



