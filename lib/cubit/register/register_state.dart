part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterChangePassword extends RegisterState {}

final class RegisterChangePassword2 extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterFailureState extends RegisterState {

  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}
