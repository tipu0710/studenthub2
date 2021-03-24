class StudentRegModel {
  String data;
  bool verified;

  StudentRegModel({this.data, this.verified});

  StudentRegModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['verified'] = this.verified;
    return data;
  }
}