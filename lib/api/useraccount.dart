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


  Future<String>addAccountDetails( ) async {

    String value="";
    final box = GetStorage();
    userToken= box.read("UserToken");
    try{
      Map data ={
        "account_holder_name": userRegisterData["account_holder_name"],
        "account_number": userRegisterData["account_number"],
        "bank_id": userRegisterData["bank_id"],
        "city": userRegisterData["city"],
        "branch": userRegisterData["branch"],
        "ifsc_code": userRegisterData["ifsc_code"]
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





  Future<String> removeDeviceToken() async {
    String loginValue = "";

    var url = '${ApiList.baseUrl}/api/notification/remove-firebase-device-token';
    await http.post(
      Uri.parse(url),
      headers: {
        "authorization":userToken
      },
    ).then((value) {
      var result = jsonDecode(value.body);
      print(result);
      if (result["status"]=="success") {
        loginValue="success";
      } else{
        loginValue="Something went wrong.";
      }

    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
      loginValue="Bad request.";
    });
    return loginValue;
  }




  Future<String>addProfileDetails( Map<String,dynamic>userData ) async {

    String value="";
    try{
      Map data ={
        "name":userData["firstName"].toString() ,
        "last_name":userData["lastName"].toString(),
        "phone": userData["mobileNumber"].toString(),
        "alt_phone": userData["alternativeMobile"].toString(),
        "email": userData["email"].toString()
      };

      String body = json.encode(data);
      var url = '${ApiList.baseUrl}/api/delivery-person/driver-edit-profile-details';
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Authorization":userToken.toString(),
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("......Add profile details ..${response.body}");
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


  Future<String>updateProfileDetails( Map<String,dynamic>userData) async {

    String value="";

    try{
      Map data ={
        "profile_id":int.parse(userData["profile_id"]),
        "first_name":userData["firstName"].toString() ,
        "last_name":userData["lastName"].toString(),
        "phone": userData["mobileNumber"].toString(),
        "alt_phone": userData["alternativeMobile"].toString(),
        "email": userData["email"].toString()
      };

      String body = json.encode(data);
      var url = '${ApiList.baseUrl}/api/user/edit-profile-details';
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Authorization":userToken.toString(),
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("...${response.body}");
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


  Future<Map<String,dynamic>> fetchUserAccount() async {

    String url= '${ApiList.baseUrl}/api/user/profile-details';
    final response = await http.get(Uri.parse(url),headers: {
      "authorization":userToken
    });
    if (response.statusCode == 200) {
      var data=json.decode(response.body);
      print("userResponce is $data");
      if(data["status"]=="success"){
        return data["data"];
      }
    } else {
      print("Failed : ${response.body}");
    }
    return {};
  }



  Future<String> addMyProfile(String profile) async {

    String result="";
    String url=ApiList.baseUrl+ApiList.uploadProfile;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['authorization'] =userToken;
    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      profile,
    ));


    try {
      var response = await request.send().timeout(const Duration(seconds: 60));
      var responseMessage = await response.stream.bytesToString();
      var responseData = jsonDecode(responseMessage);
      print(".....$responseData");
      if (responseData["status"]=="success") {
        result="success";
      } else {
        result=responseData["message"];
      }
    } catch (error) {
      print("...............${error.toString()}");
      result="Fail";
    }

    return result;
  }


  Future<String>loginAndSecurity(newPassword,confirmPassword ) async {

    String value="";

    try{


      var url = '${ApiList.baseUrl}/api/delivery-person/driver-reset-password';
      var response = await http.post(
        Uri.parse(url),
        body: {
          "new_password":newPassword,
          "confirm_password":confirmPassword,
        },
        headers: {
          "Authorization":userToken.toString(),
        },
      );
      print("...${response.body}");
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




  Future<String> sentRequestForDeleteAccount() async {
    String loginValue = "";

    var url = ApiList.baseUrl+ApiList.deleteAccount;
    await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization":userToken
      },
    ).then((value) {
      var result = jsonDecode(value.body);
      print(result);
      if (result["status"] == "success") {
        loginValue = "success";
      } else {
        loginValue=result["message"].toString();
      }
    }).onError((error, stackTrace) {
      loginValue = "Bad request.";
    });
    return loginValue;
  }

}