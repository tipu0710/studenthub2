import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class ImageUploadDialog extends StatefulWidget {
  final File image;

  const ImageUploadDialog({Key key, @required this.image}) : super(key: key);
  @override
  _ImageUploadDialogState createState() => _ImageUploadDialogState();
}

class _ImageUploadDialogState extends State<ImageUploadDialog> {
  String fileName = "No file chosen";
  Color warningColor = Colors.red;
  double width = 0;
  double height = 0;
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  var margin = 20.0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          height: 300,
          width: width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: dialogContent(context),
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(height: 150, width: 150, child: Image.file(widget.image)),

        //<---------------------------------------- Cancel and save button ----------------------------->
        buttonRow(context),
      ],
    );
  }

  Widget buttonRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 30, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (_, value, __) => IgnorePointer(
                    ignoring: value,
                    child: UiHelper().button(
                        context: context,
                        title: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: height / 18.984,
                        width: width / 4.033,
                        fontSize: 12,
                        color: Colors.white,
                        borderColor: Colors.grey,
                        textColor: Colors.black),
                  )),
          UiHelper().button(
              context: context,
              title: "Upload",
              anim: true,
              onPressed: () async {
                valueNotifier.value = true;
                Response response = await ApiService.uploadPhoto(widget.image);
                valueNotifier.value = false;
                if (mounted) {
                  Navigator.pop(context, response);
                }
              },
              height: height / 18.984,
              width: width / 4.033,
              fontSize: 12),
        ],
      ),
    );
  }
}
