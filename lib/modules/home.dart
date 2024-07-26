import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/cubit/category/category_cubit.dart';
import 'package:ecommerce_app/cubit/category_details/category_details_cubit.dart';
import 'package:ecommerce_app/cubit/favourite/favourite_cubit.dart';
import 'package:ecommerce_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/all_category.dart';
import 'package:ecommerce_app/layout/all_product.dart';
import 'package:ecommerce_app/layout/category_details.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/home_model.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OfflineBuilder(
        connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
    ) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);

          if(connected){
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final homeModel = HomeCubit.get(context).homeModel?.data;

                return state is HomeLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CarouselSlider(
                            items: homeModel?.banners
                                .map((e) => Image(
                              image: NetworkImage(e.image),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                                .toList(),
                            options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * .3,
                                initialPage: 0,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                reverse: false,
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                                enableInfiniteScroll: true,
                                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                scrollDirection: Axis.horizontal,
                                autoPlayInterval: const Duration(seconds: 3))),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Row(
                          children: [
                            TextBest(
                              text: 'Category',
                              fontSize: 16.sp,
                              color: colorTitle,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                navigateTo(context, const AllCategory());
                              },
                              child: TextBest(
                                text: 'See More',
                                fontSize: 16.sp,
                                color: colorBlue,
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            final categoryModel =
                                CategoryCubit.get(context).categoryModel;

                            return state is CategoryLoadingState
                                ? const Center(
                              child: CircularProgressIndicator(),
                            )
                                : SizedBox(
                              height: 80.h,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        CategoryDetailsCubit.get(context)
                                            .getCategoryDetails(
                                            id: categoryModel
                                                .data.data[index].id);
                                        navigateTo(context,
                                            const CategoryDetails());
                                      },
                                      child: BuildCategoriesItem(
                                        categoriesModel:
                                        categoryModel.data.data[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                  itemCount:
                                  categoryModel!.data.data.length),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Row(
                          children: [
                            TextBest(
                              text: 'Products',
                              fontSize: 16.sp,
                              color: colorTitle,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                navigateTo(context, const AllProduct());
                              },
                              child: TextBest(
                                text: 'See More',
                                fontSize: 16.sp,
                                color: colorBlue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1 / 1.5.h,
                          children: List.generate(
                              homeModel!.products.length,
                                  (index) => InkWell(
                                  onTap: (){
                                    OneCategoryCubit.get(context).oneCategoryDetails(productId: homeModel.products[index].id);
                                    navigateTo(context, ProductDetails());
                                  },
                                  child: BuildBodyProduct(homeModel: homeModel.products[index],index : index))
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Can\'t Connect home details ... Check Internet..',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  Image.asset('assets/images/no internet.png'),
                ],
              ),
            );          }
        });

  }
}

class BuildCategoriesItem extends StatelessWidget {
  const BuildCategoriesItem({super.key, required this.categoriesModel});

  final Datum categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30.w,
          backgroundImage: NetworkImage(categoriesModel.image),
        ),
        Text(
          categoriesModel.name,
          maxLines: 1,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class BuildBodyProduct extends StatelessWidget {
    const BuildBodyProduct({super.key, required this.homeModel, required this.index,  });

   final Product homeModel ;
   final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
                    height: 200,
                    child: Image(
                        image: NetworkImage(homeModel.image)))),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  homeModel.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextBest(
                      text: homeModel.price
                          .toString(),
                      color: colorBlue,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){
                          FavouriteCubit.get(context).changeFavorites(homeModel.id,index,context);
                        },
                        icon: Icon(
                          Icons.favorite,size: 28.w,
                          color: homeModel.inFavorites ? Colors.red : Colors.grey,
                        )
                    ),
                  ],
                ),
                if (homeModel.discount != 0)
                Row(
                  children: [
                    Text(homeModel.oldPrice
                            .toString(),style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: colorBlue,
                      decoration: TextDecoration.lineThrough,
                    ),),
                    SizedBox(
                      width: MediaQuery.of(context)
                          .size
                          .width *
                          .09,
                    ),
                    if (homeModel.discount != 0)
                      TextBest(
                        text: homeModel
                            .discount
                            .toString(),
                        color: Colors.red,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

