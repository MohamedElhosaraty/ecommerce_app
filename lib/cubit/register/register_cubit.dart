
import 'package:ecommerce_app/cache/cache_helper.dart';
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/register_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial());

  final ApiConsumer api;

  static RegisterCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Widget suffix = const  Icon(Icons.visibility_outlined);
  bool isPassword = true ;

  void changeShowPassword () {
    isPassword = !isPassword;
    suffix = isPassword ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined);

    emit(RegisterChangePassword());

  }

  Widget suffix2 = const  Icon(Icons.visibility_outlined);
  bool isPassword2 = true ;

  void changeShowPassword2 () {
    isPassword2 = !isPassword2;
    suffix = isPassword2 ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined);

    emit(RegisterChangePassword2());

  }

  RegisterModel? registerModel;

  void register () async {
    emit(RegisterLoadingState());
    try {
      final response = await api.post(EndPoints.register,
      data:
      {
        ApiKey.name : nameController.text ,
        ApiKey.email : emailController.text ,
        ApiKey.password : passwordController.text ,
        ApiKey.phone : phoneController.text ,

      });

      if(response['status'] == true) {
        registerModel = RegisterModel.fromJson(response);
        CacheHelper.saveData(key: ApiKey.token, value: registerModel?.data?.token);
        emit(RegisterSuccessState());
        showToast(message: response['message'].toString(),state: ToastStates.SUCCESS);
      }else{
        showToast(message: response['message'].toString(),state: ToastStates.ERROR);
        emit(RegisterFailureState(errorMessage: response['message'].toString()));

      }
    } on ServerException catch (e) {
      emit(RegisterFailureState(errorMessage: e.errorModel.message));
    }
  }
}
