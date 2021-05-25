class AddList {
  bool? isAlreadyAdded;
  int? id;
  String? name;
  String? link;
  String? image;
  int? sortingOrder;
  bool? isActive;
  int? createById;
  String? createDate;
  int? lastChangedById;
  String? lastChanged;
  bool? isDeleted;
  bool? isSelected;

  AddList(
      {this.isAlreadyAdded,
        this.id,
        this.name,
        this.link,
        this.image,
        this.sortingOrder,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  AddList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    name = json['Name'];
    link = json['Link'];
    image = json['Image'];
    sortingOrder = json['SortingOrder'];
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
    data['Name'] = this.name;
    data['Link'] = this.link;
    data['Image'] = this.image;
    data['SortingOrder'] = this.sortingOrder;
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