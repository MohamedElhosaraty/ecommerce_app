import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/api/dio_consumer.dart';
import 'package:ecommerce_app/cubit/notification/notification_cubit.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(DioConsumer(dio: Dio()))..getNotification(),
      child: Scaffold(
        appBar: AppBar(
          title: TextBest(
            text: 'Notification',
            fontSize: 25.sp,
            color: colorGrey,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            final cubit = NotificationCubit
                .get(context)
                .notificationModel;

            return state is NotificationLoadingState ? const Center(
              child: CircularProgressIndicator(),) :
            ListView.builder(
              itemCount: cubit?.data.data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.black)
                  ),
                  child: ListTile(
                    title: TextBest(
                      text: (cubit?.data.data[index].title) ?? 'mohamed',
                      fontSize: 25.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: TextBest(
                      text: cubit?.data.data[index].message ?? 'Ahmed',
                      fontSize: 25.sp,
                      color: colorGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
