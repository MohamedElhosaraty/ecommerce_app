import 'package:ecommerce_app/cache/cache_helper.dart';
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/login_model.dart';
import 'package:ecommerce_app/modules/bottom_bar.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());

  final ApiConsumer api ;

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginModel? loginModel;

  Widget suffix = const  Icon(Icons.visibility_outlined);
  bool isPassword = true ;

  void changeShowPassword () {
    isPassword = !isPassword;
    suffix = isPassword ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined);

    emit(LoginChangePasswordState());

  }



  void splashScreen (context,Widget widget)  {
    Future.delayed(const Duration(seconds: 5) , () =>
      navigateAndFinish(context, widget),
    );
   emit(SplashToLogin());
  }

  void login (context) async {
    emit(LoginLoadingState());
    try {
      final response = await api.post(EndPoints.login,
      data:
      {
        ApiKey.email : emailController.text,
        ApiKey.password : passwordController.text,
      }
      );

      if(response['status'] == true){
        loginModel = LoginModel.fromJson(response);
        CacheHelper.saveData(key: ApiKey.token, value: loginModel?.data?.token);
        emit(LoginSuccessState());
        showToast(message: loginModel!.message.toString(),state: ToastStates.SUCCESS);
        navigateAndFinish(context, const BottomBar());

      }else{
        emit(LoginFailureState(errorMessage: response['message'].toString()));
        showToast(message: response['message'].toString(),state: ToastStates.ERROR);

      }
    } on ServerException catch (e) {
      emit(LoginFailureState(errorMessage: e.errorModel.message));
    }
  }
}
