class Announcement {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String title;
  String description;
  String image;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  Announcement(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.title,
        this.description,
        this.image,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  Announcement.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    title = json['Title'];
    description = json['Description'];
    image = json['Image'];
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
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Image'] = this.image;
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