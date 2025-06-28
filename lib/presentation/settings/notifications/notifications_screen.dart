import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notification_event.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notifications_bloc.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notifications_state.dart';
import 'package:sodakkuapp/utils/constant.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static bool isNotification = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(),
      child: BlocConsumer<NotificationsBloc, NotificationState>(
        listener: (context, state) {
          if (state is NoticationOnState) {
            isNotification = state.isNotifcationOn;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: headerColor,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: headerComponentsColor,
                  size: 16,
                ),
              ),
              elevation: headerElevation,
              title: Text(
                "Notifications",
                style: TextStyle(color: headerComponentsColor),
              ),
            ),
            body: ListTile(
              tileColor: whitecolor,
              title: Text(
                "WhatsApp  Messages",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text(
                "Get notified on WhatsApp messages",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              trailing: Switch(
                value: isNotification,
                activeColor: whitecolor,
                activeTrackColor: appColor,
                inactiveTrackColor: greyColor,
                inactiveThumbColor: whitecolor,
                onChanged: (value) {
                  context.read<NotificationsBloc>().add(
                    OnNotificationEvent(isSwitched: value),
                  );
                },
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
