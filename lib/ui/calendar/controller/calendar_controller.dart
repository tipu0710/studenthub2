import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/calendar/model/event_model.dart';

import 'notification_controller.dart';

class EventController {
  Future<List<EventModel>> getEvents(
      {DateTime startTime, DateTime endTime}) async {
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
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
      return [];
    } else {
      Iterable iterable =
          jsonDecode(DataProcess.getDecryptedData(dataModel.data));
      List<EventModel> list = [];
      iterable.forEach((element) {
        list.add(EventModel.fromJson(element));
      });
      print(list.length);
      return list;
    }
  }

  Future<EventModel> createEvent(
      DateTime dateTime, TimeOfDay timeOfDay, String description) async {
    print(
        "${_doubleString(
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
      "Details": description
    };
    Response response = await ApiService.postMethod(
      ApiService.baseUrl +
          "/api/Home" +
          "/DashboardMobileApi/SaveCalendarData?input=" +
          DataProcess.getEncryptedData(jsonEncode(map)),
      allowFullUrl: false,
    );

    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
      return null;
    } else {
      print(DataProcess.getDecryptedData(dataModel.data));

      EventModel eventModel = EventModel.fromJson(
        jsonDecode(
          DataProcess.getDecryptedData(dataModel.data),
        ),
      );

      NotificationController.n.scheduleNotification(
        title: "Attention!",
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
