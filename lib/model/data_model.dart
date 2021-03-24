class DataModel {
  String data;
  bool hasError;
  dynamic dataExtra;
  List<String> errors;

  DataModel({this.data, this.hasError, this.dataExtra, this.errors});

  DataModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
    hasError = json['HasError'];
    dataExtra = json['DataExtra'];
    errors = json['Errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Data'] = this.data;
    data['HasError'] = this.hasError;
    data['DataExtra'] = this.dataExtra;
    data['Errors'] = this.errors;
    return data;
  }
}