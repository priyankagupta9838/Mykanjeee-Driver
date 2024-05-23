import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mykanjeedriver/api/apilist.dart';
import '../constrant.dart';

class NotificationServices{

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel("Mykanjee Rider", "Mykanjee Rider channel",
        importance: Importance.max, playSound: true);


    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_launcher'),
        iOS: DarwinInitializationSettings());

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    _notificationsPlugin.initialize(initializationSettings);
    // onSelectNotification: (String? route) async {
    //   if (route != null) {
    //     //Navigator.of(context).pushNamed(route);
    //   }
    // });
  }

  static void display(RemoteMessage message,String channel) async {
    try {
      final id = int.parse(channel);

      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              channel,
              "Mykanjee Rider channel",
              importance: Importance.max,
              priority: Priority.high,
              icon: "@drawable/ic_launcher"
          ),
          iOS: const DarwinNotificationDetails());

      await _notificationsPlugin.show(
        id,
        message.notification?.title?? message.data["title"],
        message.notification?.body?? message.data["body"],
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            "Mykanjee Rider",
            "Mykanjee Rider channel",
            importance: Importance.max,
            priority: Priority.high,
            icon: '@drawable/ic_launcher'
        ),
        iOS: DarwinNotificationDetails());
  }

  static void onMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    AppleNotification? appleNotification = message.notification?.apple;
    if (notification == null) return;
    if (androidNotification != null || appleNotification != null) {
      _notificationsPlugin.show(notification.hashCode, notification.title,
          notification.body, _notificationDetails());
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {

      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': "application/json",
          "Authorization":
          "key=AAAAHHpFNyE:APA91bETSPH7ymHmKB5AJSD4t384E2UuJ-c2GR7vOUzTHTj-P8CcUoThNFOXD6imuq2x6mgdZBDntQaOFdLgKmpI2YlDm_XWvY_K62M4JtTdGAFqnSVszeWSyOFNxJqVrXRLyWD4X4i8"
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          "data": <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': "done",
            'body': body,
            'title': title,
            /*"msg" : msg ? "true" : "false",
            'channel' : channel,
            'stamp' : stamp.toString().split(".")[0],
            'Email' : usermodel["Email"].toString().split('@')[0],*/
          },
          "apns": {
            "headers": {"apns-priority": "5"},
          },
          "notification": <String, dynamic>{
            'body': body,
            'title': title,
            'android_channel_id': "Mykanjee Rider"
          },
          "to": token,
          "android": {"priority": "high"},
        }),
      );
    } catch (e) {
      print("$e Send $token");}
  }



  Future<String?>getToken() async {
    String? deviceToken=await FirebaseMessaging.instance.getToken();
    return deviceToken;
  }



  Future<String> sendNotification(String id,String title , String bodyContent) async {
    String loginValue = "";

    Map data = {
      "user_id": id,
      "title": title,
      "message": bodyContent
    };

    String body = json.encode(data);
    var url = '${ApiList.baseUrl}/api/notification/send-notification-to-user';
    await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "authorization":userToken
      },
    ).then((value) {
      var result = jsonDecode(value.body);
      print("....................notification sent..$result");
      if (result["status"] == "success") {
        loginValue = "success";
      } else {
        loginValue = result["message"];
      }
    }).onError((error, stackTrace) {
      loginValue = "Server Error.";
    });
    return loginValue;
  }


}
