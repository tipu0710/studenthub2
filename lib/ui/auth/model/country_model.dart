class CountryModel {
  String? id;
  String? name;
  int? countryNumber;
  String? code;
  String? shortCode;
  String? nationality;
  String? language;
  String? languageCode;
  String? currency;
  String? currencyCode;
  String? currencySymbol;
  String? callingCode;
  String? timeZone;
  String? capital;
  String? continent;
  bool? isActive;
  String? createDate;
  String? createdById;
  String? lastChanged;
  String? lastChangedById;
  bool? isDeleted;
  bool? isSelected;
  bool? isAlreadyAdded;

  CountryModel(
      {this.id,
        this.name,
        this.countryNumber,
        this.code,
        this.shortCode,
        this.nationality,
        this.language,
        this.languageCode,
        this.currency,
        this.currencyCode,
        this.currencySymbol,
        this.callingCode,
        this.timeZone,
        this.capital,
        this.continent,
        this.isActive,
        this.createDate,
        this.createdById,
        this.lastChanged,
        this.lastChangedById,
        this.isDeleted,
        this.isSelected,
        this.isAlreadyAdded});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    countryNumber = json['CountryNumber'];
    code = json['Code'];
    shortCode = json['ShortCode'];
    nationality = json['Nationality'];
    language = json['Language'];
    languageCode = json['LanguageCode'];
    currency = json['Currency'];
    currencyCode = json['CurrencyCode'];
    currencySymbol = json['CurrencySymbol'];
    callingCode = json['CallingCode'];
    timeZone = json['TimeZone'];
    capital = json['Capital'];
    continent = json['Continent'];
    isActive = json['IsActive'];
    createDate = json['CreateDate'];
    createdById = json['CreatedById'];
    lastChanged = json['LastChanged'];
    lastChangedById = json['LastChangedById'];
    isDeleted = json['IsDeleted'];
    isSelected = json['IsSelected'];
    isAlreadyAdded = json['IsAlreadyAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['CountryNumber'] = this.countryNumber;
    data['Code'] = this.code;
    data['ShortCode'] = this.shortCode;
    data['Nationality'] = this.nationality;
    data['Language'] = this.language;
    data['LanguageCode'] = this.languageCode;
    data['Currency'] = this.currency;
    data['CurrencyCode'] = this.currencyCode;
    data['CurrencySymbol'] = this.currencySymbol;
    data['CallingCode'] = this.callingCode;
    data['TimeZone'] = this.timeZone;
    data['Capital'] = this.capital;
    data['Continent'] = this.continent;
    data['IsActive'] = this.isActive;
    data['CreateDate'] = this.createDate;
    data['CreatedById'] = this.createdById;
    data['LastChanged'] = this.lastChanged;
    data['LastChangedById'] = this.lastChangedById;
    data['IsDeleted'] = this.isDeleted;
    data['IsSelected'] = this.isSelected;
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    return data;
  }
}