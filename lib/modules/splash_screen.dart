import 'package:dio/dio.dart';
import 'package:ecommerce_app/cache/cache_helper.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/cubit/login/login_cubit.dart';
import 'package:ecommerce_app/modules/bottom_bar.dart';
import 'package:ecommerce_app/modules/login.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Widget widget ;
    if(CacheHelper.getData(key: ApiKey.token) == null){
      widget = const LoginScreen();
    }else{
      widget = const BottomBar();
    }
    LoginCubit(DioConsumer(dio: Dio())).splashScreen(
        context, widget,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlue,
      body: Center(
        child: Image.asset('assets/images/splash.png', scale: 3,),),
    );
  }
}
