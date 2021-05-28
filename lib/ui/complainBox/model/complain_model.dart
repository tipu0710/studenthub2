import 'package:studenthub2/ui/home/model/general_institute.dart';

class ComplaintCategoryModel {
  List<ComplaintLevelCategory>? complaintLevelCategory;

  ComplaintCategoryModel({this.complaintLevelCategory});

  ComplaintCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['complaintLevelCategory'] != null) {
      complaintLevelCategory = <ComplaintLevelCategory>[];
      json['complaintLevelCategory'].forEach((v) {
        complaintLevelCategory!.add(new ComplaintLevelCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintLevelCategory != null) {
      data['complaintLevelCategory'] =
          this.complaintLevelCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplaintLevelCategory {
  bool? isAlreadyAdded;
  int? id;
  int? instituteId;
  String? code;
  String? name;
  String? description;
  bool? isActive;
  int? createById;
  String? createDate;
  int? lastChangedById;
  String? lastChanged;
  bool? isDeleted;
  List<AdminComplaintCategory>? adminComplaintCategory;
  GeneralInstitute? generalInstitute;
  bool? isSelected;

  ComplaintLevelCategory(
      {this.isAlreadyAdded,
      this.id,
      this.instituteId,
      this.code,
      this.name,
      this.description,
      this.isActive,
      this.createById,
      this.createDate,
      this.lastChangedById,
      this.lastChanged,
      this.isDeleted,
      this.adminComplaintCategory,
      this.generalInstitute,
      this.isSelected});

  ComplaintLevelCategory.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    description = json['Description'];
    isActive = json['IsActive'];
    createById = json['CreateById'];
    createDate = json['CreateDate'];
    lastChangedById = json['LastChangedById'];
    lastChanged = json['LastChanged'];
    isDeleted = json['IsDeleted'];
    if (json['Admin_ComplaintCategory'] != null) {
      adminComplaintCategory = <AdminComplaintCategory>[];
      json['Admin_ComplaintCategory'].forEach((v) {
        adminComplaintCategory?.add(new AdminComplaintCategory.fromJson(v));
      });
    }
    generalInstitute = json['General_Institute'] != null
        ? GeneralInstitute.fromJson(json['General_Institute'])
        : null;
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    if (this.adminComplaintCategory != null) {
      data['Admin_ComplaintCategory'] =
          this.adminComplaintCategory?.map((v) => v.toJson()).toList();
    }
    if (this.generalInstitute != null) {
      data['General_Institute'] = this.generalInstitute?.toJson();
    }
    data['IsSelected'] = this.isSelected;
    return data;
  }
}

class AdminComplaintCategory {
  bool? isAlreadyAdded;
  int? id;
  int? complaintLevelId;
  String? code;
  String? name;
  String? description;
  bool? isActive;
  int? createById;
  String? createDate;
  int? lastChangedById;
  String? lastChanged;
  bool? isDeleted;
  bool? isSelected;

  AdminComplaintCategory(
      {this.isAlreadyAdded,
      this.id,
      this.complaintLevelId,
      this.code,
      this.name,
      this.description,
      this.isActive,
      this.createById,
      this.createDate,
      this.lastChangedById,
      this.lastChanged,
      this.isDeleted,
      this.isSelected});

  AdminComplaintCategory.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    complaintLevelId = json['ComplaintLevelId'];
    code = json['Code'];
    name = json['Name'];
    description = json['Description'];
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
    data['ComplaintLevelId'] = this.complaintLevelId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Description'] = this.description;
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
