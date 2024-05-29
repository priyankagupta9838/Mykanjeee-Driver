import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/useraccount.dart';
import '../utilityfunction.dart';

class AddProfilePicture extends StatefulWidget {
  AddProfilePicture({Key? key,required this.profilePath}) : super(key: key);
  String profilePath="";

  @override
  State<AddProfilePicture> createState() => _AddProfilePictureState();
}

class _AddProfilePictureState extends State<AddProfilePicture> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await UtilityFunctions().imagePicker().then((value) async {
          if (value.isNotEmpty) {
            widget.profilePath=value.toString();
            await UserAccount().addMyProfile(widget.profilePath);
            setState(() {

            });
          }
        });
      },
      child: widget.profilePath.isNotEmpty && widget.profilePath.contains("https://mykanjeebucket")
          ?
      CircleAvatar(
        radius: size.height * 0.06,
        backgroundImage:NetworkImage(widget.profilePath),
        child: widget.profilePath.trim().isEmpty
            ? Icon(
          Icons.person,
          size: size.height * 0.06,
          color: Colors.grey,
        )
            : null,
      )
          :
      CircleAvatar(
        radius: size.height * 0.06,
        backgroundImage:
        widget.profilePath != "" ? FileImage(File(widget.profilePath)) : null,
        child: widget.profilePath == ""
            ? Icon(
          Icons.person,
          size: size.height * 0.06,
          color: Colors.grey,
        )
            : null,
      ),
    );
  }
}