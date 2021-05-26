import 'package:studenthub2/ui/home/model/general_institute.dart';

class IntakeModel {
  List<IntakeList>? intakeList;
  List<ProgrammeList>? programmeList;
  Declaration? declaration;

  IntakeModel({this.intakeList, this.programmeList, this.declaration});

  IntakeModel.fromJson(Map<String, dynamic> json) {
    if (json['intakeList'] != null) {
      intakeList = <IntakeList>[];
      json['intakeList'].forEach((v) {
        intakeList!.add(IntakeList.fromJson(v));
      });
    }
    if (json['programmeList'] != null) {
      programmeList = <ProgrammeList>[];
      json['programmeList'].forEach((v) {
        programmeList!.add(ProgrammeList.fromJson(v));
      });
    }
    declaration = json['Declaration'] != null
        ? new Declaration.fromJson(json['Declaration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.intakeList != null) {
      data['intakeList'] = this.intakeList!.map((v) => v.toJson()).toList();
    }
    if (this.programmeList != null) {
      data['programmeList'] =
          this.programmeList!.map((v) => v.toJson()).toList();
    }
    if (this.declaration != null) {
      data['Declaration'] = this.declaration!.toJson();
    }
    return data;
  }
}

class ProgrammeList extends Intake {
  ProgrammeList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
  }
}

class IntakeList extends Intake {
  IntakeList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
  }
}

abstract class Intake {
  String? id;
  String? code;
  String? name;

  Intake({this.id, this.code, this.name});

  Intake.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    return data;
  }
}

class Declaration {
  bool? isAlreadyAdded;
  int? id;
  int? instituteId;
  String? name;
  String? declarationContent;
  String? uRL;
  bool? isActive;
  int? createById;
  String? createDate;
  int? lastChangedById;
  String? lastChanged;
  bool? isDeleted;
  GeneralInstitute? generalInstitute;
  bool? isSelected;

  Declaration(
      {this.isAlreadyAdded,
      this.id,
      this.instituteId,
      this.name,
      this.declarationContent,
      this.uRL,
      this.isActive,
      this.createById,
      this.createDate,
      this.lastChangedById,
      this.lastChanged,
      this.isDeleted,
      this.generalInstitute,
      this.isSelected});

  Declaration.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    name = json['Name'];
    declarationContent = json['DeclarationContent'];
    uRL = json['URL'];
    isActive = json['IsActive'];
    createById = json['CreateById'];
    createDate = json['CreateDate'];
    lastChangedById = json['LastChangedById'];
    lastChanged = json['LastChanged'];
    isDeleted = json['IsDeleted'];
    generalInstitute = json['General_Institute'] != null
        ? new GeneralInstitute.fromJson(json['General_Institute'])
        : null;
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Name'] = this.name;
    data['DeclarationContent'] = this.declarationContent;
    data['URL'] = this.uRL;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    if (this.generalInstitute != null) {
      data['General_Institute'] = this.generalInstitute!.toJson();
    }
    data['IsSelected'] = this.isSelected;
    return data;
  }
}
