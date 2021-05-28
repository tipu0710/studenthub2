import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class SingleCalenderEvent extends StatelessWidget {
  final EventModel eventModel;
  final Color cardColor;
  final Color shadowColor;
  const SingleCalenderEvent(
      {Key? key,
      required this.eventModel,
      required this.cardColor,
      required this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat _dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return Scaffold(
      appBar: UiHelper.appBar(context, onTap: () {
        Navigator.pop(context);
      }, title: "Event Details"),
      body: Hero(
        tag: eventModel.id ?? "${DateTime.now().microsecondsSinceEpoch}",
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.0),
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.3),
                    offset: Offset(0, 6),
                    blurRadius: 6,
                  )
                ]),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    eventModel.title ?? "Title not available",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      height: 2.5714285714285716,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "From: " +
                        dateTimeFormatter(
                            _dateFormat.format(eventModel.startDateTime!)),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Colors.black87,
                      height: 2.5714285714285716,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "To     : " +
                        dateTimeFormatter(
                            _dateFormat.format(eventModel.endDateTime!)),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Colors.black87,
                      height: 2.5714285714285716,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    eventModel.details ?? "Details not found",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                    maxLines: null,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
