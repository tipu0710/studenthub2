import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/calendar/view/calendar.dart';
import 'package:studenthub2/ui/calendar/view/event_create_dialog.dart';
import 'package:studenthub2/ui/home/model/event.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class EventUi extends StatefulWidget {
  final Event? event;
  final int position;

  const EventUi({Key? key, required this.event, required this.position})
      : super(key: key);

  @override
  _EventUiState createState() => _EventUiState();
}

class _EventUiState extends State<EventUi> {
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
                  tag: "${widget.event?.id ?? "null"}i${widget.position}",
                  child: Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: ApiService.baseUrl + widget.event!.image!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Hero(
                  tag: "title" +
                      "${widget.event?.id ?? "null"}p${widget.position}",
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 20),
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          child: Text(
                            widget.event?.name ?? "",
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
                    widget.event!.description!,
                    style: TextStyle(height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(
                      width: 20,
                    ),
                    UiHelper().button(
                        context: context,
                        title: "ADD TO CALENDAR",
                        height: 30,
                        width: 100,
                        topMargin: 20,
                        fontSize: 11,
                        onPressed: () async {
                          bool active = widget.event?.isActive??false;
                          if(!active){
                            showMessage("Event not active!");
                            return;
                          }
                          EventModel? eventModel = await showDialog(
                            context: context,
                            builder: (context) => EventCreationDialog(
                              selectedDate:
                                  widget.event?.dateFrom ?? DateTime.now(),
                              event: widget.event,
                            ),
                          );
                          if (eventModel != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Calendar(
                                  focusDate: eventModel.startDateTime,
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
