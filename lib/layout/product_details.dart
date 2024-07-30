import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/cubit/carts/carts_cubit.dart';
import 'package:ecommerce_app/cubit/favourite/favourite_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/containerbutton.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key,});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<OneCategoryCubit, OneCategoryState>(
          builder: (context, state) {
            final OneCategoryCubit cubit = OneCategoryCubit.get(context);
            return state is OneCategoryLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
              width: 200.w,
                  child: Text(
                      cubit.oneCategoryDetailsModel!.data.name,maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                                ),
                    ),
                );
          },
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<OneCategoryCubit, OneCategoryState>(
        builder: (context, state) {
          final OneCategoryCubit cubit = OneCategoryCubit.get(context);

          return state is OneCategoryLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                            items: cubit.oneCategoryDetailsModel?.data.images
                                .map((e) => Image(
                                      image: NetworkImage(e),
                                      width: double.infinity,
                                      fit: BoxFit.contain,
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
                          height: size.height * .03,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .75,
                              child: Text(
                                (cubit.oneCategoryDetailsModel!.data.name),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                FavouriteCubit.get(context).changeFavorites(
                                    cubit.oneCategoryDetailsModel!.data.id,
                                    0,
                                    context);
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 35.w,
                                color: cubit.oneCategoryDetailsModel!.data
                                        .inFavorites
                                    ? Colors.red
                                    : colorGrey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Row(
                          children: [
                            if (cubit.oneCategoryDetailsModel!.data.discount !=
                                0)
                              Text(
                                '\$${cubit.oneCategoryDetailsModel!.data.oldPrice}',
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red),
                              ),
                            if (cubit.oneCategoryDetailsModel!.data.discount !=
                                0)
                              const Spacer(),
                            TextBest(
                              text:
                                  '\$${cubit.oneCategoryDetailsModel!.data.price}',
                              fontSize: 30.sp,
                              color: colorBlue,
                            ),
                          ],
                        ),
                        TextBest(
                          text:
                              '\$${cubit.oneCategoryDetailsModel!.data.description}',
                          fontSize: 20.sp,
                          color: colorGrey,
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                         BlocBuilder<CartsCubit, CartsState>(
                                builder: (context, state) {

                                 return state is ChangeCartsLoadingState
                                      ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : ContainerButton(
                                    color: colorBlue,
                                    radius: 10,
                                    height: 50.h,
                                    onPressed: () {
                                      CartsCubit.get(context).changeCarts(
                                          cubit
                                              .oneCategoryDetailsModel!.data.id,
                                          context);
                                    },
                                    text:cubit.oneCategoryDetailsModel!.data.inCart? "Delete To Carts" :'Add To Cart',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                              ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
