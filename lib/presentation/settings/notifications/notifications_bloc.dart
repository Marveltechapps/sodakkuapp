import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notification_event.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationsBloc() : super(NotificationInitialState()) {
    on<OnNotificationEvent>(notificationOn);
  }

  notificationOn(OnNotificationEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoadingState());
    emit(NoticationOnState(isNotifcationOn: event.isSwitched));
  }
}
