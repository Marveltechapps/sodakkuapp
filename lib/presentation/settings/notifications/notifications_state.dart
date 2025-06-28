abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NoticationOnState extends NotificationState {
  final bool isNotifcationOn;

  NoticationOnState({required this.isNotifcationOn});
}
