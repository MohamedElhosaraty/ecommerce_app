import 'package:ecommerce_app/cubit/carts/carts_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/containerbutton.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/stripe_payment/payment_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) {
        final cubit = CartsCubit.get(context).cartsModel?.data;

        return state is CartsLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              child: InkWell(
                                onTap: () {
                                  OneCategoryCubit.get(context).oneCategoryDetails(
                                      productId: cubit.cartItems[index].id);
                                  navigateTo(context, ProductDetails());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: Image(
                                        image: NetworkImage(
                                            cubit.cartItems[index].product.image),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 35,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.cartItems[index].product.name,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              cubit.cartItems[index].product.price
                                                  .round()
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: (){
                                                  CartsCubit.get(context).deleteCarts(cubit.cartItems[index].id, context);
                                                }, icon: Icon(
                                              Icons.delete,color: colorGrey,size: 30.w,))
                                          ],
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
                          itemCount: cubit!.cartItems.length,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ContainerButton(
                    color: colorBlue,
                    radius: 10,
                    height: 50.h,
                    onPressed: ()=> PaymentManager.makePayment(cubit.total.round(), "EGP"),
                    text: 'Buy Now',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            );


      },
    );
  }
}
