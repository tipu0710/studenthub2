import 'dart:core';
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
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late EventController eventController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  bool loading = true;

  @override
  void initState() {
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

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

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
                  Iterable<EventModel> list = value.reversed;
                  return ListView.builder(
                    itemCount: list.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return eventCard(
                          eventModel: list.elementAt(index),
                          cardColor: getColor(index).first,
                          shadowColor: getColor(index).last);
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
      required Color shadowColor}) {
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
                      shadowColor: shadowColor)));
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
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "From: " +
                        dateTimeFormatter(
                            _dateFormat.format(eventModel.startDateTime!)),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10,
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
                      fontSize: 10,
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
