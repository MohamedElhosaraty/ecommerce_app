import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/carts_model.dart';
import 'package:ecommerce_app/model/change_carts_model.dart';
import 'package:ecommerce_app/model/delete_carts_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit(this.api) : super(CartsInitial());

  final ApiConsumer api;

  static CartsCubit get(context) => BlocProvider.of(context);

  CartsModel? cartsModel;

  void getCarts () async {
    emit(CartsLoadingState());
    try {
      final response = await api.get(ApiKey.carts);
      if(response['status'] == true ){
        cartsModel = CartsModel.fromJson(response);
        emit(CartsSuccessState());
        if(cartsModel!.data.cartItems.isEmpty){
          showToast(message: 'Don\'t have any Product in Cart '.toString(),state: ToastStates.ERROR);
        }
      }else{
        emit(CartsFailureState(errorMessage:response['message'].toString()));
        showToast(message: response['message'].toString(),state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(CartsFailureState(errorMessage: e.errorModel.message));
    }
  }

  ChangeCartsModel? changeCartsModel;

  void changeCarts (int productId,context) async
  {
    emit(ChangeCartsLoadingState());
    try {
      final response = await api.post(
          ApiKey.carts,
          data: {
            "product_id" : productId ,
          }
      );

      if(response['status'] == true){
        changeCartsModel = ChangeCartsModel.fromJson(response);
        getCarts();
        emit(ChangeCartsSuccessState());
        showToast(
            message: changeCartsModel!.message.toString(), state: ToastStates.SUCCESS);
      }else{
        emit(ChangeCartsFailureState(errorMessage: response['message'].toString()));
        showToast(
            message: response['message'].toString(), state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(ChangeCartsFailureState(errorMessage: e.errorModel.message));
    }
  }

  DeleteCartsModel? deleteCartsModel;

  void deleteCarts (int productId,context) async
  {
    emit(ChangeCartsLoadingState());
    try {
      final response = await api.delete(
          "${ApiKey.carts}/$productId",
      );

      if(response['status'] == true){
        deleteCartsModel = DeleteCartsModel.fromJson(response);
        getCarts();
        emit(ChangeCartsSuccessState());
        showToast(
            message: deleteCartsModel!.message.toString(), state: ToastStates.SUCCESS);
      }else{
        emit(ChangeCartsFailureState(errorMessage: response['message'].toString()));
        showToast(
            message: response['message'].toString(), state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(ChangeCartsFailureState(errorMessage: e.errorModel.message));
    }
  }
}
