import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/complainBox/controller/complain_controller.dart';
import 'package:studenthub2/ui/complainBox/model/complain_model.dart';
import 'package:studenthub2/ui_helper/effect.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class ComplainBox extends StatefulWidget {
  ComplainBox({Key? key}) : super(key: key);

  @override
  _ComplainBoxState createState() => _ComplainBoxState();
}

class _ComplainBoxState extends State<ComplainBox> {
  final detailsController = TextEditingController();

  final ComplainController controller = ComplainController();

  final ValueNotifier<List<AdminComplaintCategory>?> valueNotifier =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, title: "Complaint", onTap: () {
        Navigator.pop(context);
      }),
      body: FutureBuilder<bool>(
        future: controller.getComplainCategory(),
        builder: (_, snapshot) {
          late bool loading;
          if (snapshot.hasData && !snapshot.hasError) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            loading = false;
          } else {
            loading = true;
          }
          print(loading);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                loading
                    ? ShimmerLoading(
                        colors: [
                          Color(0xFFEBEBF4),
                          Color(0xFFBFBFBF),
                          Color(0xFFDFDFF5),
                        ],
                        isLoading: loading,
                        child: Container(
                          height: 50,
                          color: primaryColor,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: controller.getDropDown<ComplaintLevelCategory>(
                          hints: "Select complaint level",
                          list:
                              controller.categoryModel.complaintLevelCategory ??
                                  [],
                          getValue: (ComplaintLevelCategory c) => c.name ?? "",
                          validator: (s) {
                            if (s == null || s.isEmpty) {
                              return 'Please select level';
                            }
                            return null;
                          },
                          onChange: (com) {
                            controller.complaintLevelCategory = com;
                            valueNotifier.value = com?.adminComplaintCategory;
                          },
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                loading
                    ? ShimmerLoading(
                        colors: [
                          Color(0xFFEBEBF4),
                          Color(0xFFBFBFBF),
                          Color(0xFFDFDFF5),
                        ],
                        isLoading: loading,
                        child: Container(
                          height: 50,
                          color: primaryColor,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                        ),
                      )
                    : ValueListenableBuilder<List<AdminComplaintCategory>?>(
                        valueListenable: valueNotifier,
                        builder: (_, value, __) => Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: controller
                                  .getDropDown<AdminComplaintCategory>(
                                key: Key(controller.complaintLevelCategory?.id
                                        .toString() ??
                                    "Key"),
                                hints: "Select complaint category",
                                list: value ?? [],
                                getValue: (AdminComplaintCategory s) =>
                                    s.name ?? '',
                                validator: (s) {
                                  if (s == null || s.isEmpty) {
                                    return 'Please select category';
                                  }
                                  return null;
                                },
                                onChange: (admin) =>
                                    controller.adminComplaintCategory = admin,
                              ),
                            )),
                SizedBox(
                  height: 20,
                ),
                ShimmerLoading(
                  isLoading: loading,
                  child: title("Description"),
                ),
                getDetailsBox(loading, context),
                SizedBox(
                  height: 20,
                ),
                ShimmerLoading(
                  isLoading: loading,
                  child: title("Select an Image (optional)"),
                ),
                ShimmerLoading(
                  isLoading: loading,
                  child: imageContainer(),
                ),
                SizedBox(
                  height: 20,
                ),
                agreement(),
                UiHelper().button(
                    context: context,
                    title: "Submit",
                    anim: true,
                    onPressed: () async {
                      if (controller.complaintLevelCategory == null) {
                        showMessage("Select complaint level");
                        return;
                      }
                      if (controller.adminComplaintCategory == null) {
                        showMessage("Select complaint category");
                        return;
                      }
                      if (detailsController.text.isEmpty) {
                        showMessage("Write down your complaint!");
                        return;
                      }
                      bool b = await controller
                          .submitComplain(detailsController.text);
                      if (b) {
                        Navigator.pop(context);
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget agreement() {
    return CheckboxListTile(
        value: controller.agree,
        title: Text(
          "Hereby I declare that all the above information is true and correct",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: const Color(0xff1e5aa7),
            fontWeight: FontWeight.w500,
          ),
        ),
        onChanged: (value) {
          setState(() {
            controller.agree = value ?? true;
          });
        });
  }

  Widget imageContainer() {
    return Center(
      child: ValueListenableBuilder<File?>(
        valueListenable: controller.imageNotifier,
        builder: (_, image, __) {
          return InkWell(
            onTap: () async {
              await controller.getImage();
            },
            child: Container(
              height: 220,
              width: 240,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: image == null
                  ? Center(
                      child: Icon(
                        CupertinoIcons.photo,
                        size: 200,
                        color: primaryColor,
                      ),
                    )
                  : Center(
                      child: Image.file(
                        image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget title(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            color: const Color(0xff585858),
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget getDetailsBox(bool loading, BuildContext context) {
    return ShimmerLoading(
      isLoading: loading,
      colors: [
        Color(0xFFEBEBF4),
        Color(0xFFBFBFBF),
        Color(0xFFDFDFF5),
      ],
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 8, minHeight: 120),
        child: Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: const Color(0xff606060)),
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
              contentPadding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
      ),
    );
  }
}
