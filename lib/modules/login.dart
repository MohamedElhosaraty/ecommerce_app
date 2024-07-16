import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/cubit/login/login_cubit.dart';
import 'package:ecommerce_app/modules/register.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/containerbutton.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/text_from.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return BlocProvider(
      create: (context) => LoginCubit(DioConsumer(dio: Dio())),
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {

            final LoginCubit loginCubit = LoginCubit.get(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: loginCubit.formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/login.png', scale: 2.5,),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextBest(
                          text: 'Welcome to Lafyuu',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: colorText,
                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        TextBest(
                          text: 'Sign in to continue',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: colorGrey,
                        ),
                        SizedBox(
                          height: size.height / 35,
                        ),
                        TextForm(
                          radius: 7,
                          validate: (value) {
                            if (value == null ||
                                value.contains("@gmail.com") == false) {
                              return "Enter valid Email";
                            }
                            return null;
                          },
                          controller: loginCubit.emailController,
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Your Email',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: colorGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        TextForm(
                          radius: 7,
                          obscureText: loginCubit.isPassword,
                          suffixIcon: loginCubit.suffix,
                          validate: (value) {
                            if (value == null || value.length < 5) {
                              return "Enter valid Password";
                            }
                            return null;
                          },
                          onTap1: (){
                            loginCubit.changeShowPassword();
                          },
                          controller: loginCubit.passwordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: colorGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                       state is LoginLoadingState ?
                          const Center(child: CircularProgressIndicator(),) :
                       ContainerButton(
                          color: colorBlue,
                          onPressed: () {
                            if(loginCubit.formKey.currentState!.validate()){
                              LoginCubit.get(context).login(context);
                            }
                          },
                          text: 'Sign In',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        TextBest(
                          text: 'OR',
                          color: colorGrey,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        Container(
                          height: 57.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 55.w),
                                child: Image.asset(
                                  'assets/images/Google.png', scale: .7,),
                              ),
                              TextBest(
                                text: "Login with Google",
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: colorGrey,
                              )
                            ],
                          ),

                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        Container(
                          height: 57.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 55.w),
                                child: Image.asset(
                                  'assets/images/Facebook.png', scale: .7,),
                              ),
                              TextBest(
                                text: "Login with facebook",
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: colorGrey,
                              )
                            ],
                          ),

                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        TextBest(
                          text: 'Forgot Password?',
                          color: colorBlue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: size.height / 65,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBest(
                              text: 'Don’t have a account?',
                              color: colorGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            InkWell(
                              onTap: (){
                                navigateAndFinish(context, const RegisterScreen());
                              },
                              child: TextBest(
                                text: '  Register',
                                color: colorBlue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
