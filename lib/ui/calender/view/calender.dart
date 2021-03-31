import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calender/controller/calender_controller.dart';
import 'package:studenthub2/ui/calender/model/event_model.dart';
import 'package:studenthub2/ui/calender/view/event_create_dialog.dart';
import 'package:studenthub2/ui_helper/effect.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  EventController eventController;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    eventController = EventController();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ShimmerLoading(
              isLoading: loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        canEventMarkersOverflow: true,
                        todayColor: Colors.orange,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (DateTime date, events, holidays) {
                      if (!loading && mounted) {
                        setState(() {
                          _selectedEvents = events;
                        });
                      }
                    },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents?.map((event) => ListTile(
                            title: eventCard(
                                title: event.date.split('T')[0],
                                subtitle: event.details),
                          )) ??
                      [],
                ],
              ),
            ),
          ),
          UiHelper().back(context, title: "Calender", onTap: () {
            Navigator.pop(context);
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  Widget eventCard({@required String title, @required String subtitle}) {
    return ShimmerLoading(
      isLoading: loading,
      key: UniqueKey(),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: primaryColor,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.white,
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
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    height: 3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => EventCreationDialog(
              selectedDate: _controller.selectedDay,
            ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }

  void getData() async {
    List<EventModel> eventList = await eventController.getEvents();
    eventList.forEach((element) {
      _events = Map<DateTime, List<dynamic>>.from(decodeMap(element));
    });
    setState(() {
      loading = false;
    });
  }

  Map<DateTime, dynamic> decodeMap(EventModel eventModel) {
    String s = eventModel.date.split('T').first;
    var splited = s.split('-');
    DateTime dateTime = DateTime(int.parse(splited.first),
        int.parse(splited[1]), int.parse(splited.last));
    List<dynamic> list = _events[dateTime] ?? [];
    list.add(eventModel);
    Map<DateTime, dynamic> newMap = {};
    newMap[dateTime] = list;
    return newMap;
  }
}
