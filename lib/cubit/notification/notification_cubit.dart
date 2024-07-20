import 'package:ecommerce_app/core/api/api_consumer.dart';
import 'package:ecommerce_app/core/api/end_Points.dart';
import 'package:ecommerce_app/core/errors/exception.dart';
import 'package:ecommerce_app/model/notification_model.dart';
import 'package:ecommerce_app/shared/components/navigatorto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.api) : super(NotificationInitial());

  final ApiConsumer api;

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationModel? notificationModel ;

  void getNotification () async {
    emit(NotificationLoadingState());
    try {
      final response = await api.get(ApiKey.notifications);
      if(response['status'] == true){
        notificationModel = NotificationModel.fromJson(response);
        emit(NotificationSuccessState());
      }else{
        showToast(message: response['message'].toString(),state: ToastStates.SUCCESS);
        emit(NotificationFailureState(errorMessage: response['message'].toString()));
      }
    } on ServerException catch (e) {
      emit(NotificationFailureState(errorMessage: e.errorModel.message));
    }
  }
}
