import 'package:ecommerce_app/cubit/favourite/favourite_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {

        final cubit = FavouriteCubit.get(context).favouriteModel?.data;

        return state is FavouriteLoadingState ? const Center(child: CircularProgressIndicator(),) :
        ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              height:
              MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 4,
              child: InkWell(
                onTap: (){
                  OneCategoryCubit.get(context).oneCategoryDetails(productId: cubit.data[index].product.id);
                  navigateTo(context, ProductDetails());
                },
                child: Row(
                  children: [
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width /
                          2.5,
                      child: Image(
                        image: NetworkImage(
                            cubit.data[index].product.image),
                      ),
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width /
                          35,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              cubit.data[index].product.name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              cubit.data[index].product.price
                                  .round()
                                  .toString() ,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 30.h,
            thickness: 2,
          ),
          itemCount: cubit!.data.length, );
      },
    );
  }
}
