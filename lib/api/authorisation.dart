import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import 'package:mykanjeedriver/api/apilist.dart';
import 'dart:io';
import '../constrant.dart';





class Authentication{

  Future<String> postDriverDetails() async {
    String result="";
    String url=ApiList.baseUrl +ApiList.registerDriver;
    var request = http.MultipartRequest('POST', Uri.parse(url),);

    request.headers["Content-Type"]="multipart/form-data; boundary=<calculated when request is sent>";
    request.headers["Accept"]="*/*";
    request.fields['name'] =  userRegisterData["name"];
    request.fields['email'] = userRegisterData["email"];
    request.fields['password'] =  userRegisterData["password"];
    request.fields['phone'] = userRegisterData["mobileNumber"];
    request.fields['alt_phone'] = userRegisterData["alternativeMobile"];
    request.fields['email'] = userRegisterData["email"];
    request.fields['city'] = userRegisterData["city1"];
    request.fields['state'] = "up";
    request.fields['country'] = "India";
    request.fields['address'] =userRegisterData["address1"];
    request.fields['pincode'] = userRegisterData["pincode1"];
    request.fields['pan_card'] = userRegisterData["panNumber"];
    request.fields['aadhar_card'] = userRegisterData["adharNumber"];
    request.fields['driving_license'] = userRegisterData["drivingLicence"];


    request.files.add(await http.MultipartFile.fromPath(
      'pan_card_image',
      userRegisterData["panCardImage"].toString(),
    ));

    request.files.add(await http.MultipartFile.fromPath(
      'aadhar_card_image',
      userRegisterData["adharCardImage"].toString(),
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'driving_license_image',
      userRegisterData["drivingLicenceImage"].toString(),
    ));


    try {
      var response = await request.send().timeout(const Duration( seconds: 60));
      var responseMessage = await response.stream.bytesToString();
      var responseData = jsonDecode(responseMessage);
      print("responce data is $responseData");
      if (responseData["status"]=="success") {
        result="success";
        print("Successs.......");
      } else {

        result=responseData["message"];
        print("fail.......$result");
      }
    } catch (error) {
      print("error......$error");
      result="something went wrong";
    }

    return result;
  }



  Future<String> loginUser(String email, String password) async {
    String loginValue = "";

    bool isPhoneNumber = false;
    if (email == null) {
      isPhoneNumber = false;
    } else {
      isPhoneNumber = double.tryParse(email) != null;
    }
    Map data = {
      "username": isPhoneNumber ? "91$email" : email,
      "password": password
    };

    String body = json.encode(data);
    var url = ApiList.baseUrl+ApiList.login;

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      var result = jsonDecode(response.body);

      if (result["status"] == "success") {
        final box = GetStorage();
        box.write("UserToken", result["data"]["access_token"]);
        box.write("refreshToken", result["data"]["refresh_token"]);
        userToken= box.read("UserToken");
        print("Usertoken is $userToken");
        loginValue = "success";
      } else {
        loginValue = result["message"];
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      loginValue = "Please check your internet.";
    } catch (e) {
      print('Error: $e');
      loginValue = "An error occurred.";
    }

    return loginValue;
  }


  Future<String> getUser() async {
    String loginValue = "";
    await http.get(
      Uri.parse(ApiList.getUser),
      headers: {
        "authorization":userToken,
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).then((value) {
      var response=json.decode(value.body);
      if(response["message"]=="Session expired"){
        loginValue="Session expired";
      }
      else if(response["status"]=="success"){
        loginValue="success";
        userModel=response["data"];
      }

    }).onError((error, stackTrace) {
      print("Server Error..... ${error.toString()}");
    });
    return loginValue;
  }

}