
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
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


    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.updateLocation),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {

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


  Future<String> acceptOrderByDriver(int orderId) async {
    String responcValue = "";
    Map data = {
      "order_id": orderId,
    };


    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.acceptOrderByDriver),
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
  Future<String> rejectOrderByDriver(int orderId,String reason) async {
    String responcValue = "";
    final box = GetStorage();
     var userId= box.read("user_id");
    Map data = {
      "delivery_person_id": userId,
      "rejection_reason": reason
    };

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.rejectOrderByDriver),
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

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.collectOrder),
      body: body,
      headers: {
        "authorization":userToken,
      },
    ).then((value) {

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




  Future<Map<String , dynamic>> allAssignedOrder(String type,String status) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
        "product_or_quote": type,
        "order_status": status,
        "page": 1,
        "rows": 1

    };
 print("Map data is $data");
    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.allAssignedOrder),
      body: body,
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      if (value.body != null) {
        try {
          var jsonResponse = json.decode(value.body);
          if (jsonResponse["code"].toString() == "200") {
            responcValue = jsonResponse;
            return responcValue;
          }
        } catch (error) {
          print("eroor is .........$error");
        }
        return responcValue;
    }});
    return responcValue;
  }








}