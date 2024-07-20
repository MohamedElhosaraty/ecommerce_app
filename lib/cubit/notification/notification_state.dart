part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoadingState extends NotificationState {}

final class NotificationSuccessState extends NotificationState {}

final class NotificationFailureState extends NotificationState {

  final String errorMessage ;

  NotificationFailureState({required this.errorMessage});
}
