import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/calendar/view/event_create_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notification_controller.dart';

class EventController {
  late LinkedHashMap<DateTime, List<EventModel>> _kEvents;
  late final ValueNotifier<List<EventModel>> selectedEvents;
  List<EventModel> _list = [];

  void _init() {
    _kEvents = LinkedHashMap<DateTime, List<EventModel>>(
      equals: isSameDay,
      hashCode: _getHashCode,
    );
    selectedEvents = ValueNotifier(getEventsForDay(DateTime.now()));
  }

  Future<bool> getEvents({DateTime? startTime, DateTime? endTime}) async {
    _init();
    DateTime now = DateTime.now();
    String startDate = startTime != null
        ? "${startTime.year}-${startTime.month}-${startTime.day}00:00:00.000"
        : "${now.year}-${now.month-1}-${now.day}00:00:00.000";
    String endDate = endTime != null
        ? "${endTime.year}-${endTime.month}-${endTime.day}00:00:00.000"
        : "${now.year}-${now.month+1}-${now.day}00:00:00.000";
    Response response = await ApiService.getMethod(
        ApiService.baseUrl +
            "/api/Home" +
            "/DashboardMobileApi/GetPagedCalendar?textkey=&pageSize=-1&pageNo=-1&dateStart=$startDate&dateEnd=$endDate",
        addBaseUrl: false);

    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      showMessage(dataModel.errors!.first);
      return false;
    } else {
      Iterable iterable =
          jsonDecode(DataProcess.getDecryptedData(dataModel.data!));
      iterable.forEach((element) {
        EventModel eventModel = EventModel.fromJson(element);
        int diff = eventModel.endDateTime!
            .difference(eventModel.startDateTime!)
            .inDays;
        if (diff > 0) {
          for (int i = 0; i <= diff; i++) {
            EventModel childModel = EventModel.fromJson(eventModel.toJson());
            childModel.id = (int.parse(childModel.id!) + i).toString();
            childModel.startDateTime =
                childModel.startDateTime!.add(Duration(days: i));
            _list.add(childModel);
          }
        } else {
          _list.add(eventModel);
        }
      });
      return await _getData();
    }
  }

  Future<void> showAddDialog(
    BuildContext context,
    DateTime selectedDay,
  ) async {
    EventModel? eventModel = await showDialog(
        context: context,
        builder: (context) => EventCreationDialog(
              selectedDate: selectedDay,
            ));
    if (eventModel != null) {
      int diff =
          eventModel.endDateTime!.difference(eventModel.startDateTime!).inDays;
      if (diff > 0) {
        for (int i = 0; i <= diff; i++) {
          EventModel childModel = EventModel.fromJson(eventModel.toJson());
          childModel.id = (int.parse(childModel.id!) + i).toString();
          childModel.startDateTime =
              childModel.startDateTime!.add(Duration(days: i));
          _list.add(childModel);
        }
      } else {
        _list.add(eventModel);
      }
      await _getData();
      selectedEvents.value = _kEvents[selectedDay] ?? [];
    }
  }

  Future<bool> _getData() async {
    _kEvents.clear();
    Map<DateTime, List<EventModel>> _kEventSource = {};
    List<EventModel> list = [];
    list..addAll(_list);
    while(list.length != 0){
      EventModel element = list[0];
      DateTime dateTime = DateTime(element.startDateTime!.year,
          element.startDateTime!.month, element.startDateTime!.day);
      Iterable<EventModel> iterable = list.where((ele) {
        DateTime date = DateTime(ele.startDateTime!.year,
            ele.startDateTime!.month, ele.startDateTime!.day);
        return date.compareTo(dateTime) == 0;
      });

      List<EventModel> tempList = [];
      tempList.addAll(iterable);

      _kEventSource[dateTime] = tempList;
      tempList.forEach((element) {
        list.removeWhere((ele) => ele.id == element.id);
      });
    }
    _kEvents.addAll(_kEventSource);
    return false;
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<EventModel> getEventsForDay(DateTime day) {
    return _kEvents[day] ?? [];
  }

  Future<EventModel?> createEvent(DateTime startDateTime, DateTime endDateTime,
      TimeOfDay timeOfDay, String description, String title) async {
    Map<String, dynamic> map = {
      "StartDateTime": "${_doubleString(
        startDateTime.year.toString(),
      )}-${_doubleString(
        startDateTime.month.toString(),
      )}-${_doubleString(
        startDateTime.day.toString(),
      )}T${_doubleString(
        timeOfDay.hour.toString(),
      )}:${_doubleString(
        timeOfDay.minute.toString(),
      )}:00",
      "EndDateTime": "${_doubleString(
        endDateTime.year.toString(),
      )}-${_doubleString(
        endDateTime.month.toString(),
      )}-${_doubleString(
        endDateTime.day.toString(),
      )}T${_doubleString(
        timeOfDay.hour.toString(),
      )}:${_doubleString(
        timeOfDay.minute.toString(),
      )}:00",
      "Details": description,
      "Title": title
    };
    Response response = await ApiService.postMethod(
      ApiService.baseUrl +
          "/api/Home" +
          "/DashboardMobileApi/SaveCalendarData?input=" +
          DataProcess.getEncryptedData(jsonEncode(map)),
      allowFullUrl: false,
    );
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      print(dataModel.errors!.first);
      showMessage(dataModel.errors!.first);
      return null;
    } else {
      EventModel eventModel = EventModel.fromJson(
        jsonDecode(
          DataProcess.getDecryptedData(dataModel.data!),
        ),
      );

      int days = endDateTime.difference(startDateTime).inDays;
      int id = int.parse(eventModel.id!.substring(8, eventModel.id!.length));
      if (days > 0) {
        for (int i = 0; i <= days; i++) {
          NotificationController.n.scheduleNotification(
            title: title,
            body: description,
            id: id + i,
            payload: "payload",
            dateTime: DateTime(startDateTime.year, startDateTime.month,
                startDateTime.day + i, timeOfDay.hour, timeOfDay.minute, 0),
          );
        }
      } else {
        NotificationController.n.scheduleNotification(
          title: title,
          body: description,
          id: id,
          payload: "payload",
          dateTime: DateTime(startDateTime.year, startDateTime.month,
              startDateTime.day, timeOfDay.hour, timeOfDay.minute, 0),
        );
      }
      showMessage("Event added!");
      return eventModel;
    }
  }

  String _doubleString(String s) {
    if (s.length == 2) {
      return s;
    } else {
      return '0$s';
    }
  }
}
