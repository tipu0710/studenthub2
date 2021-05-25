class ProfileModel {
  String? id;
  String? fullName;
  String? dateOfBirth;
  String? countryId;
  int? genderEnumId;
  String? gender;
  int? religionEnumId;
  String? religion;
  int? maritalStatusEnumId;
  String? maritalStatus;
  int? bloodGroupEnumId;
  String? bloodGroup;
  String? fatherName;
  String? motherName;
  String? race;
  String? nationality;
  String? nationalIdNumber;
  int? userTypeEnumId;
  String? userType;
  int? userStatusEnumId;
  String? userStatus;
  String? instituteId;
  String? remarks;
  bool? isActive;
  String? createDate;
  String? createById;
  String? lastChanged;
  String? lastChangedById;
  bool? isSelected;
  bool? isAlreadyAdded;
  InstitutionDetails? institutionDetails;

  ProfileModel(
      {this.id,
        this.fullName,
        this.dateOfBirth,
        this.countryId,
        this.genderEnumId,
        this.gender,
        this.religionEnumId,
        this.religion,
        this.maritalStatusEnumId,
        this.maritalStatus,
        this.bloodGroupEnumId,
        this.bloodGroup,
        this.fatherName,
        this.motherName,
        this.race,
        this.nationality,
        this.nationalIdNumber,
        this.userTypeEnumId,
        this.userType,
        this.userStatusEnumId,
        this.userStatus,
        this.instituteId,
        this.remarks,
        this.isActive,
        this.createDate,
        this.createById,
        this.lastChanged,
        this.lastChangedById,
        this.isSelected,
        this.isAlreadyAdded,
      this.institutionDetails});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fullName = json['FullName'];
    dateOfBirth = json['DateOfBirth'];
    countryId = json['CountryId'];
    genderEnumId = json['GenderEnumId'];
    gender = json['Gender'];
    religionEnumId = json['ReligionEnumId'];
    religion = json['Religion'];
    maritalStatusEnumId = json['MaritalStatusEnumId'];
    maritalStatus = json['MaritalStatus'];
    bloodGroupEnumId = json['BloodGroupEnumId'];
    bloodGroup = json['BloodGroup'];
    fatherName = json['FatherName'];
    motherName = json['MotherName'];
    race = json['Race'];
    nationality = json['Nationality'];
    nationalIdNumber = json['NationalIdNumber'];
    userTypeEnumId = json['UserTypeEnumId'];
    userType = json['UserType'];
    userStatusEnumId = json['UserStatusEnumId'];
    userStatus = json['UserStatus'];
    instituteId = json['InstituteId'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
    createDate = json['CreateDate'];
    createById = json['CreateById'];
    lastChanged = json['LastChanged'];
    lastChangedById = json['LastChangedById'];
    isSelected = json['IsSelected'];
    isAlreadyAdded = json['IsAlreadyAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FullName'] = this.fullName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['CountryId'] = this.countryId;
    data['GenderEnumId'] = this.genderEnumId;
    data['Gender'] = this.gender;
    data['ReligionEnumId'] = this.religionEnumId;
    data['Religion'] = this.religion;
    data['MaritalStatusEnumId'] = this.maritalStatusEnumId;
    data['MaritalStatus'] = this.maritalStatus;
    data['BloodGroupEnumId'] = this.bloodGroupEnumId;
    data['BloodGroup'] = this.bloodGroup;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['Race'] = this.race;
    data['Nationality'] = this.nationality;
    data['NationalIdNumber'] = this.nationalIdNumber;
    data['UserTypeEnumId'] = this.userTypeEnumId;
    data['UserType'] = this.userType;
    data['UserStatusEnumId'] = this.userStatusEnumId;
    data['UserStatus'] = this.userStatus;
    data['InstituteId'] = this.instituteId;
    data['Remarks'] = this.remarks;
    data['IsActive'] = this.isActive;
    data['CreateDate'] = this.createDate;
    data['CreateById'] = this.createById;
    data['LastChanged'] = this.lastChanged;
    data['LastChangedById'] = this.lastChangedById;
    data['IsSelected'] = this.isSelected;
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    return data;
  }
}

class InstitutionDetails {
  String? programmeName;
  String? instituteName;
  String? matricId;
  String? image;

  InstitutionDetails({this.programmeName, this.instituteName, this.matricId});

  InstitutionDetails.fromJson(Map<String, dynamic> json) {
    programmeName = json['ProgrammeName'];
    instituteName = json['InstituteName'];
    matricId = json['MatricId'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProgrammeName'] = this.programmeName;
    data['InstituteName'] = this.instituteName;
    data['MatricId'] = this.matricId;
    data['Image'] = this.image;
    return data;
  }
}