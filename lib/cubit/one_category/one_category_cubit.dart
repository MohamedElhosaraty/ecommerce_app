import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/One_Category_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'one_category_state.dart';

class OneCategoryCubit extends Cubit<OneCategoryState> {
  OneCategoryCubit(this.api) : super(OneCategoryInitial());

  final ApiConsumer api ;

  static OneCategoryCubit get(context) => BlocProvider.of(context);

  OneCategoryDetailsModel? oneCategoryDetailsModel ;

  void oneCategoryDetails ({required int productId}) async {
    emit(OneCategoryLoadingState());
    try {
      final response = await api.get('${ApiKey.products}/$productId');
      if(response['status'] == true) {
        oneCategoryDetailsModel = OneCategoryDetailsModel.fromJson(response);
        emit(OneCategorySuccessState());
      }else{
        emit(OneCategoryFailureState(errorMessage: response['message'].toString()));
        showToast(message: response['message'].toString(),state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(OneCategoryFailureState(errorMessage: e.errorModel.message));
    }
  }
}
