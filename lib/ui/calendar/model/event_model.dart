import 'package:intl/intl.dart';

class EventModel {
  String? id;
  String? studentId;
  DateTime? startDateTime;
  DateTime? endDateTime;
  String? title;
  String? details;
  bool? isActive;
  String? createDate;
  String? createById;
  String? lastChanged;
  String? lastChangedById;
  bool? isDeleted;
  bool? isSelected;
  bool? isAlreadyAdded;
  bool? isEditable;

  DateFormat _dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  EventModel(
      {this.id,
      this.studentId,
      this.startDateTime,
      this.endDateTime,
      this.details,
      this.isActive,
      this.createDate,
      this.createById,
      this.lastChanged,
      this.lastChangedById,
      this.isDeleted,
      this.isSelected,
      this.isAlreadyAdded,
      this.isEditable,
      this.title});

  EventModel.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['Id'].toString();
    studentId = json['StudentId'];
    startDateTime = _dateFormat.parse(json['StartDateTime']);
    endDateTime = _dateFormat.parse(json['EndDateTime']);
    title = json['Title'];
    details = json['Details'];
    isActive = json['IsActive'];
    createDate = json['CreateDate'];
    createById = json['CreateById'];
    lastChanged = json['LastChanged'];
    lastChangedById = json['LastChangedById'];
    isDeleted = json['IsDeleted'];
    isSelected = json['IsSelected'];
    isAlreadyAdded = json['IsAlreadyAdded'];
    isEditable = json['IsEditable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StudentId'] = this.studentId;
    data['StartDateTime'] = _dateFormat.format(this.startDateTime!);
    data['EndDateTime'] = _dateFormat.format(this.endDateTime!);
    data['Title'] = this.title;
    data['Details'] = this.details;
    data['IsActive'] = this.isActive;
    data['CreateDate'] = this.createDate;
    data['CreateById'] = this.createById;
    data['LastChanged'] = this.lastChanged;
    data['LastChangedById'] = this.lastChangedById;
    data['IsDeleted'] = this.isDeleted;
    data['IsSelected'] = this.isSelected;
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['IsEditable'] = this.isEditable;
    return data;
  }
}
