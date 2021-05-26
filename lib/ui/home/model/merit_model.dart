class MeritPointModel {
  String? eventName;
  String? meritPointCollected;

  MeritPointModel({this.eventName, this.meritPointCollected});

  MeritPointModel.fromJson(Map<String, dynamic> json) {
    eventName = json['EventName'];
    meritPointCollected = json['MeritPointCollected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventName'] = this.eventName;
    data['MeritPointCollected'] = this.meritPointCollected;
    return data;
  }
}