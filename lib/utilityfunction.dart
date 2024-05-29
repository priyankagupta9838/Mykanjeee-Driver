import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykanjeedriver/api/apilist.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

class UtilityFunctions{

  Future<String> imagePicker() async {
    String filePath = "";
    ImagePicker imagePicker = ImagePicker();
    print(imagePicker);
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery);
    print(file?.path);
    if (file!.path.isNotEmpty &&  _isImage(file.path)) {
      filePath = file.path;
    }
    return filePath;
  }

  bool _isImage(String path) {
    String extension = path.split('.').last.toLowerCase();
    return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
  }





  void errorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  void successToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }





  Future<String> postImage(String type,String value) async {
    print("....Image Path is : ${value}");
    String result="";
    String url='${ApiList.baseUrl}/api/auth/image-upload';
    var request = http.MultipartRequest('POST', Uri.parse(url),);

    request.headers["Content-Type"]="multipart/form-data; boundary=<calculated when request is sent>";
    request.headers["Accept"]="*/*";

    request.fields["type"] =type.toString();
    if(value.toString().isNotEmpty){
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        value.toString(),
      ));
    }

    try {
      var response = await request.send().timeout(const Duration( seconds: 60));
      var responseMessage = await response.stream.bytesToString();
      var responseData = jsonDecode(responseMessage);
      print(responseData);
      if (responseData["status"]=="success") {
        result=responseData["data"]["key"].toString();
      }
      else {
        result="Something went wrong";
      }
    }on SocketException catch (e) {
      print('SocketException: $e');
      result ="Please check your internet.";
    }  catch (error) {
      print("Error...$error");
      result="Something went wrong";
    }

    return result;
  }


  Future<void>checkNotificationPermission()async{
    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }
  }



  void openGoogleMaps(String address) async {
    String query = Uri.encodeComponent(address);
    String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (!await launchUrl(Uri.parse(googleMapsUrl))) {
      throw Exception('Could not launch');
    }
  }



}