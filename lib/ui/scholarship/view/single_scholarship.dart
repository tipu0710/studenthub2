import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/home/model/scholarship_model.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleScholarship extends StatelessWidget {
  final ScholarshipModel? scholarshipModel;
  final int position;
  const SingleScholarship(
      {Key? key, required this.scholarshipModel, required this.position})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: UiHelper.appBar(context, onTap: () {
            Navigator.pop(context);
          }),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: "${scholarshipModel?.id ?? "null"}i$position",
                  child: Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: ApiService.baseUrl + scholarshipModel!.image!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Hero(
                  tag: "title" + "${scholarshipModel?.id ?? "null"}t$position",
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 20),
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          child: Text(
                            scholarshipModel?.name ?? "",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              color: const Color(0xff252525),
                              fontWeight: FontWeight.w500,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                  child: HtmlWidget(scholarshipModel?.description ?? "",
                      textStyle: TextStyle(height: 1.5), onTapUrl: (url) {
                    launch(url);
                  }),
                ),
                UiHelper().button(
                    context: context,
                    title: "Details",
                    height: 30,
                    width: 70,
                    topMargin: 20,
                    fontSize: 11,
                    onPressed: () {
                      try {
                        launch(scholarshipModel?.uRL ?? "");
                      } catch (e) {
                        print(scholarshipModel?.uRL);
                        UiHelper.showSnackMessage(
                            context: context, message: "Details not found!");
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
