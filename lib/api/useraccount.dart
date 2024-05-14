import 'dart:convert';
import 'package:http/http.dart'as http ;
import 'package:mykanjeedriver/api/apilist.dart';
import 'package:mykanjeedriver/constrant.dart';



class UserAccount{


  Future<String> activeUser(bool status, String lat, String long) async {
    String activeUser = "";
    Map<String, dynamic> data = {
      "is_active": status,
      "current_lat": lat,
      "current_lng": long,
    };
    String body = json.encode(data);
    await http.post(
      Uri.parse(ApiList.baseUrl+ApiList.activeUser),
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
        print(result);
        if (result["status"].toString()== "success" ) {

          activeUser= result["message"].toString();

        } else {
           activeUser=result["status"].toString();
        }
      } else {
        activeUser="null";
        print("Error Occurred : Response body is null.");
      }
    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return activeUser;
  }




  Stream<http.Response> fetchBankName()  {

    String url= '${ApiList.baseUrl}/api/bank/get-all-banks';

    return http.get(Uri.parse(url),headers: {
      "authorization":userToken
    }).asStream();
  }
}