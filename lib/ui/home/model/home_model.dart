class HomeModel {
  List<ChannelList> channelList;
  List<EventList> eventList;

  HomeModel({this.channelList, this.eventList});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['channelList'] != null) {
      channelList = <ChannelList>[];
      json['channelList'].forEach((v) {
        channelList.add(new ChannelList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = <EventList>[];
      json['eventList'].forEach((v) {
        eventList.add(new EventList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channelList != null) {
      data['channelList'] = this.channelList.map((v) => v.toJson()).toList();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChannelList {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  String generalInstitute;
  bool isSelected;

  ChannelList(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.generalInstitute,
        this.isSelected});

  ChannelList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    isActive = json['IsActive'];
    createById = json['CreateById'];
    createDate = json['CreateDate'];
    lastChangedById = json['LastChangedById'];
    lastChanged = json['LastChanged'];
    isDeleted = json['IsDeleted'];
    generalInstitute = json['General_Institute'];
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    data['General_Institute'] = this.generalInstitute;
    data['IsSelected'] = this.isSelected;
    return data;
  }
}

class EventList {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  int channelId;
  String dateFrom;
  String dateTo;
  String description;
  String image;
  bool isMeritPoint;
  double meritPoint;
  String qRCode;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  EventList(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.channelId,
        this.dateFrom,
        this.dateTo,
        this.description,
        this.image,
        this.isMeritPoint,
        this.meritPoint,
        this.qRCode,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  EventList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    channelId = json['ChannelId'];
    dateFrom = json['DateFrom'];
    dateTo = json['DateTo'];
    description = json['Description'];
    image = json['Image'];
    isMeritPoint = json['IsMeritPoint'];
    meritPoint = json['MeritPoint'];
    qRCode = json['QRCode'];
    isActive = json['IsActive'];
    createById = json['CreateById'];
    createDate = json['CreateDate'];
    lastChangedById = json['LastChangedById'];
    lastChanged = json['LastChanged'];
    isDeleted = json['IsDeleted'];
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['ChannelId'] = this.channelId;
    data['DateFrom'] = this.dateFrom;
    data['DateTo'] = this.dateTo;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['IsMeritPoint'] = this.isMeritPoint;
    data['MeritPoint'] = this.meritPoint;
    data['QRCode'] = this.qRCode;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    data['IsSelected'] = this.isSelected;
    return data;
  }
}