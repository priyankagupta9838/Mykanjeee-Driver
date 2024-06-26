
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

    Map data = {
      "order_id": orderId,
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

  Future<String> collectOrder( int orderId,String imageKey ) async {
    String responcValue = "";
    Map data = {
      "order_id":orderId,
      "order_status_image":imageKey

    };

    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.collectOrder),
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

  Future<Map<String,dynamic>> allAssignedOrder(String type,String status,int page ,int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
        "product_or_quote": type,
        "order_status": status,
        "page": page,
        "rows": row

    };

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

  Future<Map<String,dynamic>> allDeliveredOrder(String type,String status,int page ,int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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


  Future<Map<String,dynamic>> allAcceptedProductOrder(String type,String status) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      // "page": 1,
      // "rows": 1

    };

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


  Future<Map<String,dynamic>> allPickupServiceOrder(String type,String status,int page, int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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

  Future<Map<String,dynamic>> allDropOffServiceOrder(String type,String status,int page,int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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
  Future<Map<String,dynamic>>allAssignedServiceOrder(String type,String status, int page,int row) async {
    Map<String , dynamic> responceData={};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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
          if (jsonResponse["status"] == "success") {
               responceData=jsonResponse;
            return responceData;
          }
        } catch (error) {
          print("eroor is .........$error");
        }
        return [];
      }});
    return responceData;
  }
  Future<Map<String,dynamic>> allDeliveredServiceOrder(String type,String status, int page,int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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
          if (jsonResponse["status"] == "success") {
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
  Future<Map<String,dynamic>> allRejectedServiceOrder(String type,String status,int page,int row) async {
    Map<String , dynamic> responcValue = {};
    Map data = {
      "product_or_quote": type,
      "order_status": status,
      "page": page,
      "rows": row

    };

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
      print("responce value iss..${json.decode(value.body)}");
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


  Future<Map<String,dynamic>> recentActivity() async {
    Map<String , dynamic> responcValue = {};



    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.recentActivity),
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      if (value.body != null) {
        try {
          var jsonResponse = json.decode(value.body);
          if (jsonResponse["status"] == "success") {
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