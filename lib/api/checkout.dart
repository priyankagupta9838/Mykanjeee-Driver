
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:mykanjeedriver/api/apilist.dart';
import '../constrant.dart';


class CheckOut{



  Stream<http.Response> getOngoingOrders()  {
    return http.get(Uri.parse(ApiList.baseUrl+ApiList.orders),headers: {
      "authorization":userToken
    }).asStream();
  }

  Future<String> updateLocation(String lat, String long) async {
    String responcValue = "";
    Map data = {
      "current_lat": lat,
      "current_lng": long,
    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.updateLocation),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }



  Future<String> rejectOrder(String driverId, String reason) async {
    String responcValue = "";
    Map data = {
      "delivery_person_id": driverId,
      "rejection_reason": reason,
    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.rejectOrder),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }


  Future<String> acceptOrder(String driverId) async {
    String responcValue = "";
    Map data = {
      "delivery_person_id": driverId,
    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.rejectOrder),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }


  Future<String> deliveredOrder(String orderId, ) async {
    String responcValue = "";
    Map data = {
      "order_id":orderId,

    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.deliveredOrder),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }



  Future<String> collectOrder(String orderId, ) async {
    String responcValue = "";
    Map data = {
      "order_id":orderId,

    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.collectOrder),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }

  Future<String> assignOrder(String driverId, String orderId) async {
    String responcValue = "";
    Map data = {
      "delivery_person_id": driverId,
      "order_id": orderId,
    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.assignOrderToDiver),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["token"] != null) {

        } else {
          responcValue=result["message"];
        }
      } else {
        responcValue="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return responcValue;
  }








}