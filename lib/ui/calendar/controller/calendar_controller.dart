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
import 'package:studenthub2/ui/home/model/event.dart';
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
        ? "${startTime.year}-${startTime.month}-${startTime.day} 00:00:00.000"
        : "${now.year}-${DateTime.january}-1 00:00:00.000";
    String endDate = endTime != null
        ? "${endTime.year}-${endTime.month}-${endTime.day} 00:00:00.000"
        : "${now.year}-${DateTime.december}-31 00:00:00.000";
    Response response = await ApiService.getMethod(
        ApiService.baseUrl +
            "/api/Home" +
            "/DashboardMobileApi/GetPagedCalendar?textkey=&pageSize=-1&pageNo=-1&dateStart=$startDate&dateEnd=$endDate",
        addBaseUrl: false);

    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      showMessage(dataModel.errors!.first);
      throw Exception(dataModel.errors!.first);
    } else {
      Iterable iterable =
          jsonDecode(DataProcess.getDecryptedData(dataModel.data!));
      iterable.forEach((element) {
        EventModel eventModel = EventModel.fromJson(element);
        _list.add(eventModel);
        // int diff = eventModel.endDateTime!
        //     .difference(eventModel.startDateTime!)
        //     .inDays;
        // if (diff > 0) {
        //   for (int i = 0; i <= diff; i++) {
        //     EventModel childModel = EventModel.fromJson(eventModel.toJson());
        //     childModel.id = (int.parse(childModel.id!) + i).toString();
        //     childModel.startDateTime =
        //         childModel.startDateTime!.add(Duration(days: i));
        //     _list.add(childModel);
        //   }
        // } else {
        //   _list.add(eventModel);
        // }
      });
      return await _getData();
    }
  }

  Future<void> showAddDialog(BuildContext context, DateTime selectedDay,
      {int position = -1, EventModel? model}) async {
    EventModel? eventModel = await showDialog(
      context: context,
      builder: (context) => EventCreationDialog(
        selectedDate: selectedDay,
        position: position,
        event: model == null
            ? null
            : Event(
                id: int.parse(model.id!),
                name: model.title,
                description: model.details,
                dateTo: model.startDateTime,
                dateFrom: model.endDateTime,
              ),
      ),
    );
    if (eventModel != null) {
      // int diff =
      //     eventModel.endDateTime!.difference(eventModel.startDateTime!).inDays;
      // if (diff > 0) {
      //   for (int i = 0; i <= diff; i++) {
      //     EventModel childModel = EventModel.fromJson(eventModel.toJson());
      //     childModel.id = (int.parse(childModel.id!) + i).toString();
      //     childModel.startDateTime =
      //         childModel.startDateTime!.add(Duration(days: i));
      //     _list.add(childModel);
      //   }
      // } else {
      //   _list.add(eventModel);
      // }
      if (position == -1) {
        _list.add(eventModel);
      } else {
        _list[position] = eventModel;
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
    while (list.length != 0) {
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

  Future<bool> delete(
      {required String id,
      required int position,
      required DateTime selectedDatetime}) async {
    var v = DataProcess.getEncryptedData(id);
    Response response = await ApiService.postMethod(
      ApiService.baseUrl +
          "/api/Home" +
          "/DashboardMobileApi/CalendarDataDelete?input=" +
          v,
      allowFullUrl: false,
    );
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      showMessage(dataModel.errors!.first);
      throw Exception(dataModel.errors!.first);
    } else {
      int notificationId = int.parse(id.substring(11, id.length));
      NotificationController.n.cancelNotification(notificationId);
      _list.removeAt(position);
      await _getData();
      selectedEvents.value = _kEvents[selectedDatetime] ?? [];
      showMessage("Deleted!");
      return true;
    }
  }

  Future<EventModel?> createEvent(
      {required DateTime startDateTime,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required String description,
      required String title,
      required int position,
      required int id,
      required bool event}) async {
    Map<String, dynamic> map = {
      "StartDateTime": "${_doubleString(
        startDateTime.year.toString(),
      )}-${_doubleString(
        startDateTime.month.toString(),
      )}-${_doubleString(
        startDateTime.day.toString(),
      )}T${_doubleString(
        startTime.hour.toString(),
      )}:${_doubleString(
        startTime.minute.toString(),
      )}:00",
      "EndDateTime": "${_doubleString(
        startDateTime.year.toString(),
      )}-${_doubleString(
        startDateTime.month.toString(),
      )}-${_doubleString(
        startDateTime.day.toString(),
      )}T${_doubleString(
        endTime.hour.toString(),
      )}:${_doubleString(
        endTime.minute.toString(),
      )}:00",
      "Details": description,
      "Title": title
    };
    if (position != -1) {
      map['Id'] = id;
    } else {
      if (event) {
        map['IsEditable'] = false;
      } else {
        map['IsEditable'] = true;
      }
    }
    print(map);
    Response response = await ApiService.postMethod(
      ApiService.baseUrl +
          "/api/Home" +
          "/DashboardMobileApi/${position == -1 ? "SaveCalendarData" : "UpdateCalendarData"}?input=" +
          DataProcess.getEncryptedData(jsonEncode(map)),
      allowFullUrl: false,
    );
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      showMessage(dataModel.errors!.first);
      throw Exception(dataModel.errors!.first);
    } else {
      EventModel eventModel = EventModel.fromJson(
        jsonDecode(
          DataProcess.getDecryptedData(dataModel.data!),
        ),
      );

      int id = int.parse(eventModel.id!.substring(11, eventModel.id!.length));
      NotificationController.n.scheduleNotification(
        title: title,
        body: description,
        id: id,
        payload: "payload",
        dateTime: DateTime(startDateTime.year, startDateTime.month,
            startDateTime.day, startTime.hour, startTime.minute - 10, 0),
      );

      // int days = endDateTime.difference(startDateTime).inDays;
      // int id = int.parse(eventModel.id!.substring(8, eventModel.id!.length));
      // if (days > 0) {
      //   for (int i = 0; i <= days; i++) {
      //     NotificationController.n.scheduleNotification(
      //       title: title,
      //       body: description,
      //       id: id + i,
      //       payload: "payload",
      //       dateTime: DateTime(startDateTime.year, startDateTime.month,
      //           startDateTime.day + i, startTime.hour, startTime.minute, 0),
      //     );
      //   }
      // } else {
      //   NotificationController.n.scheduleNotification(
      //     title: title,
      //     body: description,
      //     id: id,
      //     payload: "payload",
      //     dateTime: DateTime(startDateTime.year, startDateTime.month,
      //         startDateTime.day, startTime.hour, startTime.minute, 0),
      //   );
      // }
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
