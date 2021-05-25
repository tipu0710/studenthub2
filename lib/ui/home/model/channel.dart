class Channel {
  String? id;
  String? instituteId;
  String? code;
  String? name;
  String? createDate;
  String? description;
  bool? isSubscribed;

  Channel(
      {this.id,
        this.instituteId,
        this.code,
        this.name,
        this.createDate,
        this.description,
        this.isSubscribed});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    createDate = json['CreateDate'];
    description = json['Description'];
    isSubscribed = json['IsSubscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['CreateDate'] = this.createDate;
    data['Description'] = this.description;
    data['IsSubscribed'] = this.isSubscribed;
    return data;
  }
}