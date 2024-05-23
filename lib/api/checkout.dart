
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


  // Future<String> deliveredOrder(int orderId) async {
  //   String result="";
  //   String url=ApiList.baseUrl+ApiList.deliveredOrder;
  //   var request = http.MultipartRequest('POST', Uri.parse(url),);
  //
  //   request.headers["Content-Type"]="multipart/form-data; boundary=<calculated when request is sent>";
  //   request.headers["Accept"]="*/*";
  //   request.fields['order_id'] =  orderId.toString();
  //
  //
  //
  //
  //   // request.files.add(await http.MultipartFile.fromPath(
  //   //   'driving_license_image',
  //   //   userRegisterData["drivingLicenceImage"].toString(),
  //   // ));
  //
  //
  //   try {
  //     var response = await request.send().timeout(const Duration( seconds: 60));
  //     var responseMessage = await response.stream.bytesToString();
  //     var responseData = jsonDecode(responseMessage);
  //     print("responce data is $responseData");
  //     if (responseData["status"]=="success") {
  //       result="success";
  //       print("Successs.......");
  //     } else {
  //
  //       result=responseData["message"];
  //       print("fail.......$result");
  //     }
  //   } catch (error) {
  //     print("error......$error");
  //     result="something went wrong";
  //   }
  //
  //   return result;
  // }
  Future<String> rejectOrderByCustomer(int orderId, String imageKey,String reason) async {
    String responcValue = "";
    Map data = {
      "order_id": orderId,
      "order_status_image": imageKey,
      "rejection_reason": reason
    };
    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.rejectOrderByCustomer),
      body: body,
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      if (value.body != null) {
        var result = jsonDecode(value.body);
        print("resulte is $result");
        if (result["status"] == "success") {
          responcValue=result["status"];
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


  Future<String> acceptOrder(int orderId) async {
    String responcValue = "";
    Map data = {
      "order_id": orderId,
    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.acceptOrder),
      body: body,
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["status"] == "success") {
          responcValue=result["status"];
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


  Future<String> deliveredOrder( int orderId,String imageKey ) async {
    String responcValue = "";
    Map data = {
      "order_id":orderId,
      "order_status_image":imageKey

    };
    print(data);

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.deliveredOrder),
      body: body,
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      print(value.body);
      if (value.body != null) {
        var result = jsonDecode(value.body);
        if (result["status"] =="success") {
          responcValue=result["status"];
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