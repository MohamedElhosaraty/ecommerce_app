import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_app/model/add_favourite.dart';
import 'package:ecommerce_app/model/favourite_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.api) : super(FavouriteInitial());

  final ApiConsumer api;

  static FavouriteCubit get(context) => BlocProvider.of(context);

  FavouriteModel? favouriteModel;

  void getFavorite () async {
    emit(FavouriteLoadingState());
    try {
      final response = await api.get(ApiKey.favorites);
      if(response['status'] == true ){
        favouriteModel = FavouriteModel.fromJson(response);
        emit(FavouriteSuccessState());
        if(favouriteModel!.data.data.isEmpty){
          showToast(message: 'Don\'t have any Favourite '.toString(),state: ToastStates.ERROR);
        }
      }else{
        emit(FavouriteFailureState(errorMessage:response['message'].toString()));
        showToast(message: response['message'].toString(),state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(FavouriteFailureState(errorMessage: e.errorModel.message));
    }
  }

  AddFavouriteModel? addFavouriteModel;

  void changeFavorites (int productId,int index,context) async
  {
    emit(ChangeFavouriteLoadingState());
    try {
      final response = await api.post(
          ApiKey.favorites,
          data: {
            "product_id" : productId ,
          }
      );

      if(response['status'] == true){
        addFavouriteModel = AddFavouriteModel.fromJson(response);
        HomeCubit.get(context).getHomeData();
        emit(ChangeFavouriteSuccessState());
        //مش بيتغير ليه
        // HomeCubit.get(context).homeModel?.data.products[index].inFavorites == false;
        // emit(ChangeFavouriteLoadingState());
        getFavorite();
      }else{
        emit(ChangeFavouriteFailureState(errorMessage: response['message'].toString()));
        showToast(
            message: response['message'].toString(), state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(ChangeFavouriteFailureState(errorMessage: e.errorModel.message));
    }
  }

}
