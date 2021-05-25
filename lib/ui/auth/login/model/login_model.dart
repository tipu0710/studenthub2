class LoginModel {
  String? id;
  String? username;
  String? name;
  int? userTypeId;
  String? dateOfBirth;
  String? instituteId;
  int? departmentId;
  String? token;
  bool? hasError;
  List<String>? errors;

  LoginModel(
      {this.id,
      this.username,
      this.name,
      this.userTypeId,
      this.dateOfBirth,
      this.instituteId,
      this.departmentId,
      this.token,
      this.hasError,
      this.errors});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['Username'];
    name = json['Name'];
    userTypeId = json['UserTypeId'];
    dateOfBirth = json['DateOfBirth'];
    instituteId = json['InstituteId'];
    departmentId = json['DepartmentId'];
    token = json['Token'];
    hasError = json['HasError'];
    errors = json['Errors'] == null ? [] : json['Errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Username'] = this.username;
    data['Name'] = this.name;
    data['UserTypeId'] = this.userTypeId;
    data['DateOfBirth'] = this.dateOfBirth;
    data['InstituteId'] = this.instituteId;
    data['DepartmentId'] = this.departmentId;
    data['Token'] = this.token;
    data['HasError'] = this.hasError;
    data['Errors'] = this.errors;
    return data;
  }
}
