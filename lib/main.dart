import 'package:dio/dio.dart';
import 'package:ecommerce_app/cache/cache_helper.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/cubit/bottom_bar/bottom_cubit.dart';
import 'package:ecommerce_app/cubit/category/category_cubit.dart';
import 'package:ecommerce_app/cubit/category_details/category_details_cubit.dart';
import 'package:ecommerce_app/cubit/favourite/favourite_cubit.dart';
import 'package:ecommerce_app/cubit/home/home_cubit.dart';
import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/cubit/profile/profile_cubit.dart';
import 'package:ecommerce_app/cubit/search/search_cubit.dart';
import 'package:ecommerce_app/modules/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BottomCubit(),

              ),
              BlocProvider(
                create: (context) => HomeCubit(DioConsumer(dio: Dio()))..getHomeData(),
              ),
              BlocProvider(
                create: (context) => CategoryCubit(DioConsumer(dio: Dio()))..getDataCategories(),
              ),
              BlocProvider(
                create: (context) => CategoryDetailsCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => OneCategoryCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => SearchCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => ProfileCubit(DioConsumer(dio: Dio()))..getUserData(),
              ),
              BlocProvider(
                create: (context) => FavouriteCubit(DioConsumer(dio: Dio()))..getFavorite(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-commerce_App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                useMaterial3: true,
              ),
              home: const SplashScreen(),
            ),
          );
        }
    );
  }
}


