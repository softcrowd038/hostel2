import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // int countdownDuration = 30;
  // Timer? countdownTimer;

  // void startNotificationWithCountdown() {
  //   countdownTimer?.cancel();

  //   countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     countdownDuration--;
  //     if (countdownDuration > 0) {
  //       updateNotificationContent(countdownDuration);
  //     } else {
  //       timer.cancel();
  //     }
  //   });

  //   createInitialNotification();
  // }

  void createInitialNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "accident_channel",
          title: "Accident Detected",
          body: "Is these is an Accident Confirm.",
          color: Colors.orange),
      actionButtons: [
        NotificationActionButton(
          key: "cancel",
          label: "Cancel",
          actionType: ActionType.DismissAction,
        ),
      ],
    );
  }

  // void updateNotificationContent(int countdownValue) {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //         id: 10,
  //         channelKey: "accident_channel",
  //         title: "Accident Detected",
  //         body:
  //             "Is these is an Accident Confirm.\nTimeLeft: $countdownValue seconds",
  //         color: Colors.orange),
  //     actionButtons: [
  //       NotificationActionButton(
  //         key: "cancel",
  //         label: "Cancel",
  //         actionType: ActionType.DismissAction,
  //       ),
  //     ],
  //   );
  // }

  void cancelNotification() {
    AwesomeNotifications().cancel(10);
  }
}
