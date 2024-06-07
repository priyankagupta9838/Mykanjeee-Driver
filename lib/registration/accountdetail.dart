import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import 'package:searchfield/searchfield.dart';
import '../api/useraccount.dart';
import '../constrant.dart';
import '../routes/routesname.dart';
import '../utilityfunction.dart';




class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AcountDetailState();
}

class _AcountDetailState extends State<AccountDetail> {
  TextEditingController nameController=TextEditingController();
  TextEditingController accountNumController=TextEditingController();
  TextEditingController bankController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController branchController=TextEditingController();
  TextEditingController ifscController=TextEditingController();
  List<String>bankName=[];
  String selectedBankId="";
  bool buttonClicked=false;
  bool ifscValidation=true;
  @override
  void initState() {
    // TODO: implement initState

    nameController.text=userRegisterData["account_holder_name"] ??"";
    accountNumController.text= userRegisterData["account_number"]??"";
    bankController.text= userRegisterData["bank"]??"";
   cityController.text= userRegisterData["city"]??"";
   branchController.text=userRegisterData["branch"]??"";
   ifscController.text= userRegisterData["ifsc_code"]??"";
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height*1,
        width: size.width*1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                color: const Color.fromRGBO(247, 244, 249, 1),
                height: size.height * 0.12,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      AutoSizeText(
                        "Account Detail",
                        style: GoogleFonts.openSans(
                            decoration: TextDecoration.none,
                            color: const Color.fromRGBO(28, 28, 30, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: size.height * 0.025),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:  size.height*0.018,right:  size.height*0.018,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("Account Holder Name *",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.height*0.02),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter here",
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("Account Number*",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.height*0.02),
                        child: TextField(
                          controller: accountNumController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter here",
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("Bank Name *",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // border: Border.all(color: Colors.black)
                      ),
                      child: StreamBuilder(
                        stream: UserAccount().fetchBankName(),
                        builder: (context, snapshot) {
                          if( snapshot.hasData ){
                            var data=jsonDecode(snapshot.data!.body);
                            print("data massege is ${data}");
                            List<dynamic>bankIdList=[];
                            bankName.clear();

                            for(var id in data["message"]){
                              bankName.add(id["bank_name"]);
                              bankIdList.add(id["id"]);
                            }

                            return snapshot.data?.statusCode==200
                                ?
                            SearchField(
                              controller: bankController,
                              enabled: true,
                              suggestionItemDecoration: SuggestionDecoration(

                              ),
                              key: const Key("Search key"),
                              suggestions:
                              bankName.map((e) => SearchFieldListItem(e)).toList(),
                              searchStyle: GoogleFonts.openSans(
                                  color: Colors.black87,
                                  fontSize: size.height*0.018,
                                  fontWeight: FontWeight.w500),
                              suggestionStyle: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: size.height*0.016,
                                fontWeight: FontWeight.w600,
                              ),
                              marginColor: Colors.white,
                              suggestionsDecoration: SuggestionDecoration(
                                padding:  EdgeInsets.only(left: size.height*0.01,right: size.height*0.01),
                                //shape: BoxShape.rectangle,
                              ),
                              searchInputDecoration: InputDecoration(
                                  hintText: "Select Bank",
                                  contentPadding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.022),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  suffixIcon: Icon(Icons.arrow_drop_down,size: size.width*0.055,color: Colors.black87,),
                                  hintStyle: GoogleFonts.openSans(
                                      color: Colors.grey,
                                      fontSize: size.height*0.02,
                                      fontWeight: FontWeight.w500),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  disabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  )

                              ),
                              onSuggestionTap: (value) {
                                int position=bankName.indexOf(value.searchKey);
                                bankController.text=value.searchKey;
                                selectedBankId=bankIdList[position].toString();
                              },
                              itemHeight: 50,
                              maxSuggestionsInViewPort: 3,
                            )
                                :
                            SearchField(
                              controller: bankController,
                              enabled: true,
                              suggestionItemDecoration: SuggestionDecoration(

                              ),
                              key: const Key("Search key"),
                              suggestions:
                              bankName.map((e) => SearchFieldListItem(e)).toList(),
                              searchStyle: GoogleFonts.openSans(
                                  color: Colors.black87,
                                  fontSize: size.height*0.018,
                                  fontWeight: FontWeight.w500),
                              suggestionStyle: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: size.height*0.016,
                                fontWeight: FontWeight.w600,
                              ),
                              marginColor: Colors.white,
                              suggestionsDecoration: SuggestionDecoration(
                                padding:  EdgeInsets.only(left: size.height*0.01,right: size.height*0.01),
                                //shape: BoxShape.rectangle,

                              ),
                              searchInputDecoration: InputDecoration(
                                  hintText: "Select Bank",
                                  contentPadding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.022),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  suffixIcon: Icon(Icons.arrow_drop_down,size: size.width*0.055,color: Colors.black87,),
                                  hintStyle: GoogleFonts.openSans(
                                      color: Colors.grey,
                                      fontSize: size.height*0.02,
                                      fontWeight: FontWeight.w500),
                                  disabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),

                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  )

                              ),
                              onSuggestionTap: (value) {

                              },
                              itemHeight: 50,
                              maxSuggestionsInViewPort: 3,
                            );
                          }
                          else{
                            return SearchField(
                              controller: bankController,
                              enabled: true,
                              suggestionItemDecoration: SuggestionDecoration(

                              ),
                              key: const Key("Search key"),
                              suggestions:
                              bankName.map((e) => SearchFieldListItem(e)).toList(),
                              searchStyle: GoogleFonts.openSans(
                                  color: Colors.black87,
                                  fontSize: size.height*0.018,
                                  fontWeight: FontWeight.w500),
                              suggestionStyle: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: size.height*0.016,
                                fontWeight: FontWeight.w600,
                              ),
                              marginColor: Colors.white,
                              suggestionsDecoration: SuggestionDecoration(
                                padding:  EdgeInsets.only(left: size.height*0.01,right: size.height*0.01),
                                //shape: BoxShape.rectangle,

                              ),
                              searchInputDecoration: InputDecoration(
                                  hintText: "Select Bank",
                                  contentPadding: EdgeInsets.only(top: size.height*0.02,left: size.width*0.022),
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  suffixIcon: Icon(Icons.arrow_drop_down,size: size.width*0.055,color: Colors.black87,),
                                  hintStyle: GoogleFonts.openSans(
                                      color: Colors.grey,
                                      fontSize: size.height*0.02,
                                      fontWeight: FontWeight.w500),
                                  disabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                      //style: BorderStyle.none
                                    ),
                                    borderRadius: BorderRadius.circular(size.height*0.006),
                                  )

                              ),
                              onSuggestionTap: (value) {

                              },
                              itemHeight: 50,
                              maxSuggestionsInViewPort: 3,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("City*",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.height*0.02),
                        child:  TextField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter here",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("Branch*",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.height*0.02),
                        child: TextField(
                          controller: branchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter here",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText("IFSC Code*",
                      style:GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:  size.height*0.018,
                          fontWeight: FontWeight.w500
                      ) ,
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      height: size.height*0.056,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border:ifscValidation? Border.all(color: Colors.black):Border.all(color: Colors.red)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: size.height*0.02),
                        child:  TextField(
                          controller: ifscController,
                          onChanged: (value) {
                            String uppercaseValueIfsc = value.toUpperCase();
                            ifscController.text = uppercaseValueIfsc;
                            String panRegex = r'^[A-Z]{4}0[A-Z0-9]{6}$';
                            final regExp = RegExp(panRegex);
                            if (!regExp.hasMatch( value.toString().toString())) {
                              ifscValidation = false;
                              setState(() {});
                            } else {
                              ifscValidation = true;
                              setState(() {});
                            }
                          },

                          decoration:  const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter here",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.06,
                    ),

                    SizedBox(
                      height: size.height*0.052,
                      width: size.width*0.95,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(size.height*0.01))),
                            backgroundColor:ThemColors.buttonColor,

                        ),
                        onPressed: () {
                          if(nameController.text.isNotEmpty && accountNumController.text.isNotEmpty && bankController.text.isNotEmpty && cityController.text.isNotEmpty && branchController.text.isNotEmpty && ifscController.text.isNotEmpty  && ifscValidation){
                            userRegisterData["account_holder_name"] =nameController.text.toString();
                          userRegisterData["account_number"]= accountNumController.text.toString();
                          userRegisterData["bank_id"] = selectedBankId.toString();
                          userRegisterData["city"]  =cityController.text.toString();
                          userRegisterData["branch"]  = branchController.text.toString();
                          userRegisterData["ifsc_code"]  = ifscController.text.toString();
                            userRegisterData["bank"]= bankController.text;

                            buttonClicked=true;
                            setState(() {

                            });
                            UserAccount().addAccountDetails().then((value) {
                              if(value=="success"){
                                buttonClicked=false;
                                setState(() {

                                });
                                userRegisterData.clear();
                                var box=GetStorage();
                                box.remove("UserToken");

                                UtilityFunctions().successToast("Account Created Successfully.");
                                Navigator.pushNamedAndRemoveUntil(context, RoutesName.detailSaved, (route) => false);
                              }
                              else{
                                buttonClicked=false;
                                setState(() {

                                });
                                UtilityFunctions().errorToast(value.toString());
                              }

                            });
                          }
                          else{
                            UtilityFunctions().errorToast( "All fields are required.");
                          }


                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buttonClicked
                                ?
                            Center(
                              child: SizedBox(
                                height: size.height*0.03,
                                width: size.height*0.03,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                                :
                            AutoSizeText("Submit",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: size.height*0.022,
                                  fontWeight: FontWeight.w500
                              ),
                            ),

                          ],
                        ),
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    ) ;

  }

}