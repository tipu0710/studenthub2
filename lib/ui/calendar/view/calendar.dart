import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calendar/controller/calendar_controller.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/calendar/view/single_calender_event.dart';
import 'package:studenthub2/ui_helper/effect.dart';
import 'package:studenthub2/ui_helper/hero_route.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime? focusDate;

  const Calendar({Key? key, this.focusDate}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late EventController eventController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  bool loading = true;

  @override
  void initState() {
    _focusedDay = widget.focusDate ?? DateTime.now();

    eventController = EventController();
    super.initState();
    _selectedDay = _focusedDay;
    getData();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      eventController.selectedEvents.value =
          eventController.getEventsForDay(selectedDay);
    }
  }

  final kFirstDay = DateTime(DateTime.now().year, DateTime.january, 1);
  final kLastDay = DateTime(DateTime.now().year, DateTime.december, 31);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, title: "Calendar", onTap: () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: ShimmerLoading(
          isLoading: loading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar<EventModel>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                },
                eventLoader: eventController.getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<List<EventModel>>(
                valueListenable: eventController.selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length + 1,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return index == value.length
                          ? SizedBox(
                              height: 40,
                            )
                          : eventCard(
                              eventModel: value.elementAt(index),
                              cardColor: getColor(index).first,
                              shadowColor: getColor(index).last,
                              position: index,
                            );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await eventController.showAddDialog(context, _selectedDay);
          setState(() {
            print("came");
          });
        },
      ),
    );
  }

  Widget eventCard(
      {required EventModel eventModel,
      required Color cardColor,
      required Color shadowColor,
      required int position}) {
    DateFormat _dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return ShimmerLoading(
      isLoading: loading,
      key: Key(eventModel.id ?? "${DateTime.now().microsecondsSinceEpoch}"),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            HeroRoute(
              builder: (_) => SingleCalenderEvent(
                eventModel: eventModel,
                cardColor: cardColor,
                shadowColor: shadowColor,
              ),
            ),
          );
        },
        child: Hero(
          tag: eventModel.id ?? "${DateTime.now().microsecondsSinceEpoch}",
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 15),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventModel.title ?? "Title not available",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                height: 2.5714285714285716,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "From: " +
                                  dateTimeFormatter(_dateFormat
                                      .format(eventModel.startDateTime!)),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10,
                                color: Colors.black87,
                                height: 2.5714285714285716,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "To     : " +
                                  dateTimeFormatter(_dateFormat
                                      .format(eventModel.endDateTime!)),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10,
                                color: Colors.black87,
                                height: 2.5714285714285716,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                print(eventModel.isEditable);
                                if (eventModel.isEditable ?? true) {
                                  await eventController.showAddDialog(
                                      context, _selectedDay,
                                      position: position, model: eventModel);
                                } else {
                                  UiHelper.showSnackMessage(
                                      context: context,
                                      message:
                                          "You have no permission to edit admin event!");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  CupertinoIcons.pen,
                                  color: shadowColor,
                                  size: 15,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                bool b = await showAlertDialog(context);
                                if (b) {
                                  bool delete = await eventController.delete(
                                      id: eventModel.id!,
                                      position: position,
                                      selectedDatetime: _selectedDay);
                                  if (delete && mounted) {
                                    setState(() {
                                      print("Deleted");
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 85),
                    child: Text(
                      eventModel.details ?? "Details not found",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        height: 2,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showAlertDialog(BuildContext context) async {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure want to delete this event?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );
    bool? b = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return b ?? false;
  }

  final List<List<Color>> _colorList = [
    [Color(0xffEEF6FF), Color(0xff5F9DEE)],
    [Color(0xffF2FCFF), Color(0xff78cce2)],
    [Color(0xffe7e0ff), Color(0xff967fe2)],
    [Color(0xfffee0ff), Color(0xffd07fe2)],
    [Color(0xffffe0e0), Color(0xffe27f7f)],
    [Color(0xfffff6e0), Color(0xffe2c67f)],
    [Color(0xfff1ffe0), Color(0xffa5e27f)],
    [Color(0xffe0fff2), Color(0xff7fe2c3)],
    [Color(0xffe0f8ff), Color(0xff7fc3e2)],
  ];

  List<Color> getColor(int position) {
    return _colorList[position % _colorList.length];
  }

  void getData() async {
    var b = await eventController.getEvents();
    if (mounted) {
      setState(() {
        loading = b;
        eventController.selectedEvents.value =
            eventController.getEventsForDay(_selectedDay);
      });
    }
  }
}
