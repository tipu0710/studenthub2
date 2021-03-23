class UniversityModel {
  List<String> webPages;
  String country;
  String stateProvince;
  List<String> domains;
  String name;
  String alphaTwoCode;

  UniversityModel(
      {this.webPages,
        this.country,
        this.stateProvince,
        this.domains,
        this.name,
        this.alphaTwoCode});

  UniversityModel.fromJson(Map<String, dynamic> json) {
    webPages = json['web_pages'].cast<String>();
    country = json['country'];
    stateProvince = json['state-province'];
    domains = json['domains'].cast<String>();
    name = json['name'];
    alphaTwoCode = json['alpha_two_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['web_pages'] = this.webPages;
    data['country'] = this.country;
    data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    data['name'] = this.name;
    data['alpha_two_code'] = this.alphaTwoCode;
    return data;
  }
}
