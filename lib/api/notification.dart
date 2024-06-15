import 'package:http/http.dart'as http;

import '../constrant.dart';
import 'apilist.dart';

class NotificationApi{


  Stream<http.Response> getNotification()  {
    return http.get(Uri.parse(ApiList.baseUrl+ApiList.notification),headers: {
      "authorization":userToken
    }).asStream();
  }
}

