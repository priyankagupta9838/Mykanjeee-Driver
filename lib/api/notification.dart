import 'dart:convert';

import 'package:http/http.dart'as http;

import '../constrant.dart';
import 'apilist.dart';

class NotificationApi{


  Stream<http.Response> getNotification()  {
    return http.get(Uri.parse(ApiList.baseUrl+ApiList.notification),headers: {
      "authorization":userToken
    }).asStream();
  }

  Future<String> deleteNotification(  String couponId, ) async {

    String loginValue = "";
    var url = '${ApiList.baseUrl}/api/notification/delete-notification';
    await http.post(
      Uri.parse(url),
      body:json.encode({
        "notificationId": couponId,
      }),
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "Accept": "*/*",

      },
    ).then((value) {
      var result = jsonDecode(value.body);print("notification $result");
      if (result["status"]=="success") {
        loginValue="success";
      } else{
        loginValue=result["message"];
      }

    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
      loginValue="Bad request.";
    });
    return loginValue;
  }
}

