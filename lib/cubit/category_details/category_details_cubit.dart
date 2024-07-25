
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/category_details_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  CategoryDetailsCubit(this.api) : super(CategoryDetailsInitial());

  final ApiConsumer api ;

  static CategoryDetailsCubit get(context) => BlocProvider.of(context);

  CategoryDetailsModel? categoryDetailsModel ;

  void getCategoryDetails ({required int id}) async {
    emit(CategoryDetailsLoadingState());
    try {
      final response = await api.get('${ApiKey.categories}/$id');
      if(response['status'] == true){
        categoryDetailsModel = CategoryDetailsModel.fromJson(response);
        emit(CategoryDetailsSuccessState());
      }else{
          emit(CategoryDetailsFailureState(errorMessage: response['message'].toString()));
          showToast(message: response['message'].toString(),state: ToastStates.SUCCESS);
      }
    } on ServerException catch (e) {
      emit(CategoryDetailsFailureState(errorMessage: e.errorModel.message));
    }
  }
}
