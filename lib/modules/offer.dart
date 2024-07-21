import 'package:ecommerce_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/modules/home.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {

        final homeModel = HomeCubit.get(context).productOffer;

        return state is HomeLoadingState ? const Center(child: CircularProgressIndicator(),) :
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.5.h,
              children: List.generate(
                  homeModel.length,
                      (index) => InkWell(
                      onTap: (){
                        OneCategoryCubit.get(context).oneCategoryDetails(productId: homeModel[index].id);
                        navigateTo(context, ProductDetails());
                      },
                      child:
                      BuildBodyProduct(homeModel: homeModel[index],index: index,))
              ),
            ),
          ),
        );
      },
    );
  }
}

