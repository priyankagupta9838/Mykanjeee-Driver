import 'dart:convert';
import 'package:get_storage/get_storage.dart';
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


  Future<String>addAccountDetails( Map<String,dynamic>accountData) async {

    String value="";
    final box = GetStorage();
    String userId=box.read("user_id").toString();
    userToken= box.read("UserToken");
    print(userId);
    try{
      Map data ={
        "user_id":userId,
        "account_holder_name": accountData["account_holder_name"],
        "account_number": accountData["account_number"],
        "bank_id": accountData["bank_id"],
        "city": accountData["city"],
        "branch": accountData["branch"],
        "ifsc_code": accountData["ifsc_code"]
      };

      String body = json.encode(data);
      var url = ApiList.baseUrl+ApiList.updateAccountDetails;
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Authorization":userToken,
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("......Add Account details address..${response.body}");
      print(response.statusCode);
      var result=jsonDecode(response.body);

      if(result["status"]=="success"){
        value="success";
      }
      else {
        value=result["message"];
      }
    }
    catch(error){
      value=error.toString();
    }


    return value;
  }







  Stream<http.Response> fetchBankName()  {

    String url= '${ApiList.baseUrl}/api/bank/get-all-banks';

    return http.get(Uri.parse(url),headers: {
      "authorization":userToken
    }).asStream();
  }
}