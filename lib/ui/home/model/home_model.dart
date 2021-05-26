import 'package:studenthub2/ui/home/model/channel.dart';
import 'package:studenthub2/ui/home/model/event.dart';
import 'package:studenthub2/ui/home/model/institute.dart';
import 'ad_list.dart';
import 'announcement.dart';
import 'merit_model.dart';
import 'scholarship_model.dart';

class HomeModel {
  List<Channel>? channelList;
  List<Event>? eventList;
  Institute? institute;
  List<Announcement>? announcementList;
  List<AddList>? addList;
  List<ScholarshipModel>? scholarshipList;
  List<MeritPointModel>? meritPointList;

  HomeModel(
      {this.channelList,
      this.eventList,
      this.institute,
      this.announcementList,
      this.addList,
      this.meritPointList});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['channelList'] != null) {
      channelList = <Channel>[];
      json['channelList'].forEach((v) {
        channelList!.add(new Channel.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = <Event>[];
      json['eventList'].forEach((v) {
        eventList!.add(new Event.fromJson(v));
      });
    }
    institute = json['institute'] != null
        ? new Institute.fromJson(json['institute'])
        : null;
    if (json['announcementList'] != null) {
      announcementList = <Announcement>[];
      json['announcementList'].forEach((v) {
        announcementList!.add(new Announcement.fromJson(v));
      });
    }
    if (json['addList'] != null) {
      addList = <AddList>[];
      json['addList'].forEach((v) {
        addList!.add(AddList.fromJson(v));
      });
    }
    if (json['scholarshipList'] != null) {
      scholarshipList = <ScholarshipModel>[];
      json['scholarshipList'].forEach((v) {
        scholarshipList!.add(ScholarshipModel.fromJson(v));
      });
    }
    if (json['meritPointList'] != null) {
      meritPointList = <MeritPointModel>[];
      json['meritPointList'].forEach((v) {
        meritPointList!.add(MeritPointModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channelList != null) {
      data['channelList'] = this.channelList!.map((v) => v.toJson()).toList();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList!.map((v) => v.toJson()).toList();
    }
    if (this.institute != null) {
      data['institute'] = this.institute!.toJson();
    }
    if (this.announcementList != null) {
      data['announcementList'] =
          this.announcementList!.map((v) => v.toJson()).toList();
    }
    if (this.addList != null) {
      data['addList'] = this.addList!.map((v) => v.toJson()).toList();
    }
    if (this.scholarshipList != null) {
      data['scholarshipList'] =
          this.scholarshipList!.map((v) => v.toJson()).toList();
    }
    if (this.meritPointList != null) {
      data['meritPointList'] =
          this.meritPointList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
