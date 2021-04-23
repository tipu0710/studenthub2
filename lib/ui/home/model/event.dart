class Event {
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

  Event(
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

  Event.fromJson(Map<String, dynamic> json) {
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