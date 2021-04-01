class EventModel {
  String id;
  String studentId;
  String date;
  String details;
  bool isActive;
  String createDate;
  String createById;
  String lastChanged;
  String lastChangedById;
  bool isDeleted;
  bool isSelected;
  bool isAlreadyAdded;

  EventModel(
      {this.id,
        this.studentId,
        this.date,
        this.details,
        this.isActive,
        this.createDate,
        this.createById,
        this.lastChanged,
        this.lastChangedById,
        this.isDeleted,
        this.isSelected,
        this.isAlreadyAdded});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    studentId = json['StudentId'];
    date = json['Date'];
    details = json['Details'];
    isActive = json['IsActive'];
    createDate = json['CreateDate'];
    createById = json['CreateById'];
    lastChanged = json['LastChanged'];
    lastChangedById = json['LastChangedById'];
    isDeleted = json['IsDeleted'];
    isSelected = json['IsSelected'];
    isAlreadyAdded = json['IsAlreadyAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StudentId'] = this.studentId;
    data['Date'] = this.date;
    data['Details'] = this.details;
    data['IsActive'] = this.isActive;
    data['CreateDate'] = this.createDate;
    data['CreateById'] = this.createById;
    data['LastChanged'] = this.lastChanged;
    data['LastChangedById'] = this.lastChangedById;
    data['IsDeleted'] = this.isDeleted;
    data['IsSelected'] = this.isSelected;
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    return data;
  }
}