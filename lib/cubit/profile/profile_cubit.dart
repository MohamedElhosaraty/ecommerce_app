
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/profile_model.dart';
import 'package:ecommerce_app/model/up_profile_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial());
  final ApiConsumer api;

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void getUserData() async {
    emit(ProfileLoadingState());

    try {
      final response = await api.get(ApiKey.profile);

      if (response['status'] == true) {
        profileModel = ProfileModel.fromJson(response);

        nameController.text = profileModel?.data.name ?? '';
        emailController.text = profileModel?.data.email ?? '';
        phoneController.text = profileModel?.data.phone ?? '';

        emit(ProfileSuccessState());
      } else {
        emit(ProfileFailureState(errorMessage: response['message'].toString()));
        showToast(
            message: response['message'].toString(), state: ToastStates.ERROR);
      }
    } on ServerException catch (e) {
      emit(ProfileFailureState(errorMessage: e.errorModel.message));
    }
  }

  UpDateProfileModel? upDateProfileModel;

  void upDateProfile(
      {required String name, required String email, required String phone}) async {
    try {
      emit(UpDateProfileLoadingState());
      final response = await api.put(ApiKey.update,
          data: {
            ApiKey.name: name,
            ApiKey.email: email,
            ApiKey.phone: phone,
              "image" : img64,
          });

      upDateProfileModel = UpDateProfileModel.fromJson(response);

      if (upDateProfileModel?.status == true) {
        emit(UpDateProfileSuccessState());
        getUserData();
      } else {
        emit(UpDateProfileFailureState(
            errorMessage: upDateProfileModel!.message));
      }
    } on ServerException catch (e) {
      emit(UpDateProfileFailureState(errorMessage: e.errorModel.message));
    }
  }

  File? profileImage;
  Uint8List? bytes;
  String? img64;
  ImagePicker imagePicker =ImagePicker();

  Future<void> getImage () async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera );
    if(image != null ){
      profileImage = File(image.path);
      emit(UploadImageStates());
    }
    bytes = File(profileImage!.path).readAsBytesSync();
    img64 = base64Encode(bytes!);
  }
}
