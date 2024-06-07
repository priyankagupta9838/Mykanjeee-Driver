import 'package:flutter/cupertino.dart';

int totalSeconds=80;

Map<String,dynamic> userRegisterData={};
RegExp emailPassword = RegExp(r'[A-Za-z0-9@._-]');
String userToken="";
Map<dynamic,dynamic> userModel={};
String userAddress="";
var userLat="";
var userLong="";
String userId="";
//service order
PageController serviceOrderPageController = PageController();