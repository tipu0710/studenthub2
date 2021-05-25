class IntakeModel {
  List<IntakeList>? intakeList;
  List<ProgrammeList>? programmeList;

  IntakeModel({this.intakeList, this.programmeList});

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
