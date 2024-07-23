import 'package:ecommerce_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/modules/home.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBest(
          text:'AllProduct',
          fontSize: 25.sp,
          color: colorGrey,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeModel = HomeCubit.get(context).homeModel?.data;

          return state is HomeLoadingState ? const Center(child: CircularProgressIndicator(),):
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1 / 1.5.h,
                children: List.generate(
                    homeModel!.products.length,
                        (index) =>
                        InkWell(
                            onTap: () {
                              OneCategoryCubit.get(context).oneCategoryDetails(
                                  productId: homeModel.products[index].id);
                              navigateTo(context, ProductDetails());
                            },
                            child: BuildBodyProduct(
                                homeModel: homeModel.products[index],index: index,))
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
