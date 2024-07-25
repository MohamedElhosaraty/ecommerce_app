import 'package:ecommerce_app/cubit/category_details/category_details_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBest(
          text: "CategoryDetails",
          fontSize: 20.sp,
          color: colorBlue,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {

          final cubit = CategoryDetailsCubit.get(context).categoryDetailsModel?.data;
          return state is CategoryDetailsLoadingState ?
            const Center(child:  CircularProgressIndicator(),) :

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: GridView.count(
               crossAxisCount: 2,
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               crossAxisSpacing: 10.0,
               mainAxisSpacing: 10.0,
               childAspectRatio: 1 / 1.5.h,
              children: List.generate(
                  cubit!.data.length, (index) => InkWell(
                onTap: (){
                  OneCategoryCubit.get(context).oneCategoryDetails(productId: cubit.data[index].id);
                  navigateTo(context, ProductDetails());
                },
                    child: Container(
                                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.black)
                                    ),
                                    child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: 200,
                                child: Image(image: NetworkImage(cubit.data[index].image)))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.data[index].name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                 fontWeight: FontWeight.bold
                              ),
                            ),
                            TextBest(
                              text: cubit.data[index].price.toString(),color: colorBlue,),
                            Row(
                              children: [
                                TextBest(text: cubit.data[index].oldPrice.toString()),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .1,
                                ),
                                if(cubit.data[index].discount != 0)
                                TextBest(text: cubit.data[index].discount.toString(),color: Colors.red,),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                                    ),
                                  ),
                  ),
              ),
             ),
           );
        },
      ),
    );
  }
}
