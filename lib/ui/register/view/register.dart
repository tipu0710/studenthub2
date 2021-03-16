import 'package:flutter/material.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Register extends StatelessWidget {
  final TextEditingController passport = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 90,),
                  UiHelper().input(passport, "NRIC/Passport"),
                  UiHelper().input(passport, "Full Name"),
                  UiHelper().input(passport, "Student ID"),
                ],
              ),
            ),
          ),
          back(context),
        ],
      ),
    );
  }

  Widget back(BuildContext context){
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: (){Navigator.pop(context);},
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Container(
            height: 40, width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffecebef),
            ),
            child: Center(
              child: Icon(Icons.arrow_back_ios_sharp, size: 18,),
            ),
          ),
        ),
      ),
    );
  }
}
