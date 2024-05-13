import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'Authentication/login.dart';
import 'api/authorisation.dart';
import 'constrant.dart';
import 'navigationbar.dart';



class StorageStream extends StatefulWidget {
  const StorageStream({Key? key}) : super(key: key);

  @override
  _StorageStreamState createState() => _StorageStreamState();
}

class _StorageStreamState extends State<StorageStream> {
  final box = GetStorage();
  bool dataFetched=false;
  bool loginValue=false;
  @override
  void initState() {
    super.initState();
    userToken=box.read("UserToken").toString();
    whereToGo();
    print("User token is : $userToken");

  }

  @override
  Widget build(BuildContext context) {
    return  loginValue
        ?
    const Navigation()
        :
    const LogInPage();
  }

  Future<void> whereToGo() async{
    if(userToken!="null"){
      Authentication().getUser().then((value){
        if(value=="Session expired"){
          setState(() {
            loginValue=false;
          });
        }
        else{
          if(value=="success"){
            setState(() {
              loginValue=true;
            });
          }
        }
      });

    }
    else{
      setState(() {
        loginValue=false;
      });
    }

  }

}
