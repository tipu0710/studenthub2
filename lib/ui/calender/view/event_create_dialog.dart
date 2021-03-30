import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class EventCreationDialog extends StatefulWidget {
  @override
  _EventCreationDialogState createState() => _EventCreationDialogState();
}

class _EventCreationDialogState extends State<EventCreationDialog> {
  List<String> tagList = [];
  TextEditingController nameController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  TextEditingController tagsController = new TextEditingController();

  double margin = 20;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          width: 320.0,
          height: 400,
          padding: EdgeInsets.only(
              left: margin * 2, right: margin * 2, top: margin, bottom: margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Create Event',
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue LT 65 Medium',
                          fontSize: 15,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xff505763),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: margin),
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue LT 65 Medium',
                      fontSize: 12,
                      color: const Color(0xff505763),
                      height: 1.83,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.2, color: const Color(0xff606060)),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: tagsController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontFamily: 'HelveticaNeue LT 65 Medium',
                        fontSize: 13,
                        color: const Color(0xff505763),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 0, top: 0),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (text) {
                        if (tagList.isNotEmpty) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (String value) {
                        setState(() {
                          tagList.add(value);
                          tagsController.clear();
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: margin),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue LT 65 Medium',
                      fontSize: 12,
                      color: const Color(0xff505763),
                      height: 1.83,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 120,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.2, color: const Color(0xff606060)),
                  ),
                  child: TextFormField(
                    controller: detailsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'HelveticaNeue LT 65 Medium',
                      height: 1.3,
                      fontSize: 13,
                      color: const Color(0xff505763),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                    ),
                    validator: (text) {
                      if (text == null || text == "") {
                        return "";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                UiHelper().button(
                    context: context,
                    title: "SAVE",
                    onPressed: () {},
                    height: 27,
                    width: 78,
                    fontSize: 12,
                    topMargin: 20),
              ],
            ),
          )),
    );
  }
}
