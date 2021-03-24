class RegisterModel {
  String identityNumber;
  String fullName;
  String studentId;
  String sex;
  String emailAddress;
  String countryId;
  String contactNumber;
  String instituteId;
  String intakeId;
  String programmeId;

  RegisterModel(
      {this.identityNumber,
        this.fullName,
        this.studentId,
        this.sex,
        this.emailAddress,
        this.countryId,
        this.contactNumber,
        this.instituteId,
        this.intakeId,
        this.programmeId});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    identityNumber = json['IdentityNumber'];
    fullName = json['FullName'];
    studentId = json['StudentId'];
    sex = json['Sex'];
    emailAddress = json['EmailAddress'];
    countryId = json['CountryId'];
    contactNumber = json['ContactNumber'];
    instituteId = json['InstituteId'];
    intakeId = json['IntakeId'];
    programmeId = json['ProgrammeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdentityNumber'] = this.identityNumber;
    data['FullName'] = this.fullName;
    data['StudentId'] = this.studentId;
    data['Sex'] = this.sex;
    data['EmailAddress'] = this.emailAddress;
    data['CountryId'] = this.countryId;
    data['ContactNumber'] = this.contactNumber;
    data['InstituteId'] = this.instituteId;
    data['IntakeId'] = this.intakeId;
    data['ProgrammeId'] = this.programmeId;
    return data;
  }
}