import 'package:ecommerce_app/modules/account.dart';
import 'package:ecommerce_app/modules/cart.dart';
import 'package:ecommerce_app/modules/home.dart';
import 'package:ecommerce_app/modules/offer.dart';
import 'package:ecommerce_app/modules/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_state.dart';

class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(BottomInitial());

  static BottomCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> screen =
    const  [
      HomeScreen(),
      FavouriteScreen(),
      CartScreen(),
      OfferScreen(),
      AccountScreen(),
      ];

  void changeBottom (int index) {
    currentIndex = index ;
    emit(BottomChangeNavBarInitial());
  }

}
