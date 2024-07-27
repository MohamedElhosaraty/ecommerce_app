import 'package:ecommerce_app/cubit/one_category/one_category_cubit.dart';
import 'package:ecommerce_app/cubit/search/search_cubit.dart';
import 'package:ecommerce_app/layout/product_details.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:ecommerce_app/shared/components/text_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = SearchCubit.get(context).searchModel?.data;

          return Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
              child: Column(
                children: [
                  TextForm(
                    controller: searchController,
                    hintText: 'Search',
                    keyBoard: TextInputType.text,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.black),
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "enter text to search";
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      SearchCubit.get(context)
                          .getSearch(text: searchController.text);
                    },
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.black),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(state is SearchLoadingState)
                       const Center(
                          child: CircularProgressIndicator(),
                        ),
                  if(state is SearchSuccessState)
                  Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: InkWell(
                                    onTap: (){
                                      OneCategoryCubit.get(context).oneCategoryDetails(productId: cubit.data[index].id);
                                      navigateTo(context, ProductDetails());
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2.5,
                                          child: Image(
                                            image: NetworkImage(
                                                cubit.data[index].image),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  35,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              cubit.data[index].name,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Text(
                                              cubit.data[index].price
                                                  .round()
                                                  .toString() ,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.blueAccent,
                                              ),
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
                              itemCount: cubit!.data.length, ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
