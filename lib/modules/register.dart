import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/cubit/register/register_cubit.dart';
import 'package:ecommerce_app/modules/login.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/containerbutton.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/text_from.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterCubit(DioConsumer(dio: Dio())),
      child: Scaffold(
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final RegisterCubit registerCubit = RegisterCubit.get(context);

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: registerCubit.formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/login.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextBest(
                          text: 'Let’s Get Started',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: colorText,
                        ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        TextBest(
                          text: 'Create an new account',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: colorGrey,
                        ),
                        SizedBox(
                          height: size.height / 35,
                        ),
                        TextForm(
                          radius: 7,
                          controller: registerCubit.nameController,
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Full Name',
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
                          controller: registerCubit.phoneController,
                          prefixIcon: const Icon(Icons.phone_android_outlined),
                          hintText: 'Phone',
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
                          validate: (value) {
                            if (value == null ||
                                value.contains("@gmail.com") == false) {
                              return "Enter valid Email";
                            }
                            return null;
                          },
                          controller: registerCubit.emailController,
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
                          validate: (value) {
                            if (value == null || value.length < 5) {
                              return "Enter valid Password";
                            }
                            return null;
                          },
                          obscureText: registerCubit.isPassword,
                          suffixIcon: registerCubit.suffix,
                          onTap1: () {
                            registerCubit.changeShowPassword();
                          },
                          controller: registerCubit.passwordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Password',
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
                          validate: (value) {
                            if (value !=
                                registerCubit.passwordController.text) {
                              return "Password Not Confirmation";
                            }
                            return null;
                          },
                          obscureText: registerCubit.isPassword2,
                          suffixIcon: registerCubit.suffix2,
                          onTap1: () {
                            registerCubit.changeShowPassword2();
                          },
                          controller:
                              registerCubit.confirmationPasswordController,
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Password Again',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: colorGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        state is RegisterLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ContainerButton(
                                color: colorBlue,
                                onPressed: () {
                                  if (registerCubit.formKey.currentState!
                                      .validate()) {
                                    registerCubit.register();
                                  }
                                },
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        SizedBox(
                          height: size.height / 55,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBest(
                              text: 'have a account?',
                              color: colorGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            InkWell(
                              onTap: () {

                                  navigateAndFinish(
                                      context, const LoginScreen());
                              },
                              child: TextBest(
                                text: '  Sign in',
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
