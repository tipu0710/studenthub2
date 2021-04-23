import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/calendar/view/event_create_dialog.dart';
import 'package:studenthub2/ui/home/model/announcement.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class AnnouncementUi extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementUi({Key key, @required this.announcement}) : super(key: key);

  @override
  _AnnouncementUiState createState() => _AnnouncementUiState();
}

class _AnnouncementUiState extends State<AnnouncementUi> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: widget.announcement.id.toString(),
                      child: Container(
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: ApiService.baseUrl + widget.announcement.image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Hero(
                      tag: "title" + widget.announcement.id.toString(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 40, left: 20, right: 20, bottom: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              child: Text(
                                widget.announcement?.title ?? "",
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
                      child: Text(
                        widget.announcement.description,
                        style: TextStyle(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    UiHelper().button(
                        context: context,
                        title: "BACK",
                        height: 30,
                        width: 70,
                        topMargin: 20,
                        fontSize: 11,
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              UiHelper().back(context, onTap: () {
                Navigator.pop(context);
              }),
            ],
          )),
    );
  }
}
