import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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







}