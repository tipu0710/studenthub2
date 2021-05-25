import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';
import 'package:studenthub2/ui/calendar/view/event_create_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'notification_controller.dart';

class EventController {
  late LinkedHashMap<DateTime, List<EventModel>> _kEvents;
  Map<DateTime, List<EventModel>> _events = {};
  late final ValueNotifier<List<EventModel>> selectedEvents;
  List<EventModel> _list = [];

  void _init(){
    _kEvents = LinkedHashMap<DateTime, List<EventModel>>(
      equals: isSameDay,
      hashCode: _getHashCode,
    );
    selectedEvents = ValueNotifier(getEventsForDay(DateTime.now()));
  }

  Future<bool> getEvents({DateTime? startTime, DateTime? endTime}) async {
    _init();
    String startDate = startTime != null
        ? "${startTime.year}-${startTime.month}-${startTime.day}00:00:00.000"
        : '';
    String endDate = endTime != null
        ? "${endTime.year}-${endTime.month}-${endTime.day}00:00:00.000"
        : '';
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
        _list.add(EventModel.fromJson(element));
      });
      return await _getData();
    }
  }

  showAddDialog(
    BuildContext context,
    DateTime selectedDay,
  ) async {
    EventModel? eventModel = await showDialog(
        context: context,
        builder: (context) => EventCreationDialog(
              selectedDate: selectedDay,
            ));
    if (eventModel != null) {
      _list.add(eventModel);
      selectedEvents.value = _kEvents[selectedDay] ?? [];
    }
  }

  Future<bool> _getData() async {
    _list.forEach((element) {
      _events = Map<DateTime, List<EventModel>>.from(_decodeMap(element));
    });
    _kEvents.addAll(_events);
    return false;
  }

  Map<DateTime, List<EventModel>> _decodeMap(EventModel eventModel) {
    String s = eventModel.date!.split('T').first;
    var splited = s.split('-');
    DateTime dateTime = DateTime(int.parse(splited.first),
        int.parse(splited[1]), int.parse(splited.last));
    List<EventModel> list = _events[dateTime] ?? [];
    list.add(eventModel);
    Map<DateTime, List<EventModel>> newMap = {};
    newMap[dateTime] = list;
    return newMap;
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<EventModel> getEventsForDay(DateTime day) {
    return _kEvents[day] ?? [];
  }

  Future<EventModel?> createEvent(
      DateTime dateTime, TimeOfDay timeOfDay, String? description,
      {String? title}) async {
    print("${_doubleString(
      dateTime.year.toString(),
    )}-${_doubleString(
      dateTime.month.toString(),
    )}-${_doubleString(
      dateTime.day.toString(),
    )}T${_doubleString(
      timeOfDay.hour.toString(),
    )}:${_doubleString(
      timeOfDay.minute.toString(),
    )}:00");
    Map<String, dynamic> map = {
      "Date": "${_doubleString(
        dateTime.year.toString(),
      )}-${_doubleString(
        dateTime.month.toString(),
      )}-${_doubleString(
        dateTime.day.toString(),
      )}T${_doubleString(
        timeOfDay.hour.toString(),
      )}:${_doubleString(
        timeOfDay.minute.toString(),
      )}:00",
      "Details": description ?? "No description"
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
      showMessage(dataModel.errors!.first);
      return null;
    } else {
      print(DataProcess.getDecryptedData(dataModel.data!));

      EventModel eventModel = EventModel.fromJson(
        jsonDecode(
          DataProcess.getDecryptedData(dataModel.data!),
        ),
      );

      NotificationController.n.scheduleNotification(
        title: title ?? "Attention!",
        body: description,
        id: SPData.spData.getNotificationId(),
        payload: "payload",
        dateTime: DateTime(dateTime.year, dateTime.month, dateTime.day,
            timeOfDay.hour, timeOfDay.minute, 0),
      );
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
