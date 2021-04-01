import 'dart:convert';

import 'package:dio/dio.dart';
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

  Future<EventModel> createEvent(DateTime dateTime, String description) async {
    Map<String, dynamic> map = {
      "Date": "${dateTime.year}-${dateTime.month}-${dateTime.day}T00:00:00",
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
        dateTime:
            DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0),
      );
      showMessage("Event added!");
      return eventModel;
    }
  }
}
