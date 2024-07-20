import 'package:ecommerce_app/cubit/bottom_bar/bottom_cubit.dart';
import 'package:ecommerce_app/layout/notification.dart';
import 'package:ecommerce_app/layout/search.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
   BottomBar({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCubit, BottomState>(
    builder: (context, state) {

      final cubit = BottomCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title:InkWell(
            onTap: (){
              navigateTo(context, SearchScreen());
            },
            child: Container(
              height: 50.h,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const Icon(Icons.search,color: Colors.blueAccent,),
                 Padding(
                   padding: EdgeInsets.only(left: 20.w),
                   child: TextBest(
                       text: 'Search Product',
                     fontWeight: FontWeight.w400,
                     fontSize: 15.sp,
                     color: Colors.grey,
                   ),
                 ),
              ],),
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
                onPressed: (){
                  navigateTo(context,const NotificationScreen());
                },
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
