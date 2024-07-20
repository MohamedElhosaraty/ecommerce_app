import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());

  final ApiConsumer api;

  static HomeCubit get(context) => BlocProvider.of(context);

  List productOffer = [];

  HomeModel? homeModel ;

  void getHomeData () async {
    emit(HomeLoadingState());
    try {
      final response = await api.get(ApiKey.home);
      homeModel = HomeModel.fromJson(response);
      emit(HomeSuccessState());
      homeModel?.data.products.forEach((element) {
        if(element.discount != 0){
          productOffer.addAll(
              {
                 element
              }
          );
        }
      });
    } on ServerException catch (e) {
      emit(HomeFailureState(errorMessage: e.errorModel.message));
    }
  }
}
