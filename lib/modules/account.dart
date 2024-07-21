import 'package:ecommerce_app/cache/cache_helper.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/cubit/profile/profile_cubit.dart';
import 'package:ecommerce_app/modules/login.dart';
import 'package:ecommerce_app/shared/components/containerbutton.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      final ProfileCubit profileCubit = ProfileCubit.get(context);

      return state is ProfileLoadingState  || state is UpDateProfileLoadingState
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      profileCubit.getImage();
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          NetworkImage(profileCubit.profileModel!.data.image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15.0),
                    child: TextField(
                      controller: profileCubit.nameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: const OutlineInputBorder(),
                          hintText: "Name",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'font',
                              color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15.0),
                    child: TextField(
                      controller: profileCubit.emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder(),
                          hintText: "Email",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'font',
                              color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15.0),
                    child: TextField(
                      controller: profileCubit.phoneController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_android),
                          border: const OutlineInputBorder(),
                          hintText: "Phone",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'font',
                              color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15.0),
                    child: ContainerButton(
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'font'),
                        text: "SIGNOUT",
                        onPressed: () {
                          CacheHelper.removeData(key: ApiKey.token)
                              .then((value) {
                            if (value) {
                              navigateAndFinish(context, const LoginScreen());
                            }
                          });
                        }),
                  ),
        state is UpDateProfileLoadingState ? const CircularProgressIndicator() :

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 15.0),
          child: ContainerButton(style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'font'
          ),
              text: "UPDATE", onPressed: () {
                BlocProvider.of<ProfileCubit>(context)
                    .upDateProfile(
                    name: profileCubit.nameController.text,
                    email: profileCubit.emailController.text,
                    phone: profileCubit.phoneController.text
                );
              }),
              ),
      ],),
            );
    });
  }
}
