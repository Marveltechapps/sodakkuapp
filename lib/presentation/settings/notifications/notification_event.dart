abstract class NotificationEvent {}

class OnNotificationEvent extends NotificationEvent {
  final bool isSwitched;

  OnNotificationEvent({required this.isSwitched});
}
