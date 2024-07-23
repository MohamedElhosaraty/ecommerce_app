import 'package:ecommerce_app/cubit/category/category_cubit.dart';
import 'package:ecommerce_app/cubit/category_details/category_details_cubit.dart';
import 'package:ecommerce_app/layout/category_details.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/shared/components/color.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/textbest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextBest(
            text:'AllCategory',
          fontSize: 25.sp,
          color: colorGrey,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body:  BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          final categoryModel =
              CategoryCubit.get(context).categoryModel;

          return state is CategoryLoadingState
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      CategoryDetailsCubit.get(context)
                          .getCategoryDetails(
                          id: categoryModel
                              .data.data[index].id);
                      navigateTo(context,
                          const CategoryDetails());
                    },
                    child: BuildAllCategory(
                      categoriesModel: categoryModel.data.data[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(
                      height: 20.w,
                    ),
                itemCount:
                categoryModel!.data.data.length),
          );
        },
      ),

    );
  }
}

class BuildAllCategory extends StatelessWidget {
  const BuildAllCategory({super.key, required this.categoriesModel});

  final Datum categoriesModel;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        leading: Image(
          image: NetworkImage(
            categoriesModel.image,
          ),
        ),
        title: Center(
          child: TextBest(
            text: categoriesModel.name,
          ),
        ),
      ),
    );
  }
}
