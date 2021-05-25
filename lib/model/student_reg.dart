import 'dart:convert';

class StudentRegModel {
  String? data;
  bool? verified;
  String? otp;

  StudentRegModel({this.data, this.verified, this.otp});

  StudentRegModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    verified = json['verified'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['verified'] = this.verified;
    data['otp'] = this.otp;
    return data;
  }

  @override
  String toString() {
    super.toString();
    return jsonEncode(toJson());
  }
}