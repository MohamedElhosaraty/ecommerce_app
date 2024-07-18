import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.api) : super(CategoryInitial());

  final ApiConsumer api;

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryModel? categoryModel;

  void getDataCategories () async {
    try {
      emit(CategoryLoadingState());
      final response = await api.get(ApiKey.categories);
      categoryModel = CategoryModel.fromJson(response);
      emit(CategorySuccessState());

    } on ServerException catch (e) {
      emit(CategoryFailureState(errorMessage: e.errorModel.message));
    }



  }

}
