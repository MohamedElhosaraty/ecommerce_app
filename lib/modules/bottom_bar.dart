import 'package:ecommerce_app/cubit/bottom_bar/bottom_cubit.dart';
import 'package:ecommerce_app/shared/components/text_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCubit, BottomState>(
    builder: (context, state) {

      final cubit = BottomCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: TextForm(
            radius: 10,
            prefixIcon: const Icon(Icons.search,color: Colors.blueAccent,),
            hintText: 'Search Product',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              color: Colors.grey,
            ),
          ),
          actions: 
          [
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  size: 40.w,
                  color: Colors.grey,

                ),
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 40.w,
                  color: Colors.grey,

                ),
            ),
          ],
        ),
          body: cubit.screen[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            showUnselectedLabels: false,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer_outlined), label: 'Offer'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account')
            ]),
        );
      },
    );
  }
}
