import 'dart:convert';

import 'package:mykanjeedriver/api/apilist.dart';
import 'package:http/http.dart'as http;

class ValidationApi{



  Future<bool> validatePanNumber(String panNumber,String firstname,String lastname,String dob) async {
    var apiUrl = '${ApiList.baseUrl}/api/auth/verify-pan-number';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'pan': panNumber,
          "name": firstname.toString()+lastname.toString(),
          "dob": dob.toString()


        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == 200) {
          final data = responseData['data'];
          print("$data");
          if (data.containsKey('valid')) {
            return data['valid'];
          } else {
            print('Invalid response format: "valid" key missing in data');
            return false;
          }
        } else {
          print('Failed to validate GST number: ${responseData['message']}');
          return false;
        }
      } else {
        print('Failed to validate GST number: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  Future<bool> validateAadharNumber(String aadharNumber) async {
    var apiUrl = '${ApiList.baseUrl}/api/auth/verify-aadhar-number';
    try {
      var requestBody = json.encode({'aadhar': aadharNumber});

      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("responce is");
      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey("data") && responseData["data"].containsKey("valid")) {

          bool isValid = responseData["data"]["valid"] == true;
          return isValid;
        } else {
          print('Invalid response format or "valid" key missing');
          return false;
        }
      } else {
        print('Failed to validate Aadhar number: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false; // Return false if there's an error
    }
  }



}