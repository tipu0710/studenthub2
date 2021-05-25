class PassResetModel {
  String? studentId;
  String? code;
  String? email;

  PassResetModel({this.studentId, this.code, this.email});

  PassResetModel.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'];
    code = json['Code'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentId'] = this.studentId;
    data['Code'] = this.code;
    data['Email'] = this.email;
    return data;
  }
}