import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationService {
  static const String _channelKey = 'basic_channel';
  static const String _channelName = 'Basic Notifications';
  static const String _channelDescription =
      'Notification channel for basic tests';

  static Future<void> init() async {
    log('Initializing LocalNotificationService...');
    try {
      await AwesomeNotifications()
          .initialize('resource://mipmap/launcher_icon', [
            NotificationChannel(
              channelKey: _channelKey,
              channelName: _channelName,
              channelDescription: _channelDescription,
              defaultColor: const Color(0xFF1E88E5),
              ledColor: const Color(0xFF1E88E5),
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              playSound: true,
              enableVibration: true,
              criticalAlerts: true,
            ),
          ], debug: true);

      await _requestPermission();
      _setListeners();
      log('LocalNotificationService initialized successfully.');
    } catch (e) {
      log('Error initializing LocalNotificationService: $e');
    }
  }

  static Future<void> _requestPermission() async {
    final bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static void _setListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log('onNotificationCreatedMethod: ${receivedNotification.id}');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    log('onNotificationDisplayedMethod: ${receivedNotification.id}');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('onDismissActionReceivedMethod: ${receivedAction.id}');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('onActionReceivedMethod: ${receivedAction.id}');
    // Navigation logic goes here
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    Map<String, String>? payload,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: _channelKey,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }
}
