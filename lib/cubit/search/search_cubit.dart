
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/search_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.api) : super(SearchInitial());
  
  final ApiConsumer api ;
  
  static SearchCubit get(context)  => BlocProvider.of(context);

  SearchModel? searchModel;
  
  void getSearch ({required String text}) async {
    emit(SearchLoadingState());
    try {
      final response = await api.post(ApiKey.search,
      data: {
        'text' : text,
      }
      );
      if(response['status'] == true){
        searchModel = SearchModel.fromJson(response);
        emit(SearchSuccessState());
        if(searchModel!.data.data.isEmpty){
          showToast(message: 'Don\'t have any thing  ',state: ToastStates.ERROR);
        }
      }else{
        showToast(message: response['message'].toString(),state: ToastStates.SUCCESS);
        emit(SearchFailureState(errorMessage: response['message'].toString()));
      }
    } on ServerException catch (e) {
      emit(SearchFailureState(errorMessage: e.errorModel.message));
    }
  }
}
