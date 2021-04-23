class Institute {
  bool isAlreadyAdded;
  int id;
  String code;
  String referralCode;
  String name;
  String shortName;
  String longName;
  String description;
  String address1;
  String address2;
  String postcode;
  int cityId;
  int stateId;
  int countryId;
  String officeNumber;
  String faxNumber;
  String emailAddress;
  String webUrl;
  String logo;
  String facebookUrl;
  String instagramUrl;
  String linkedInUrl;
  String contactDetails;
  String remarks;
  bool isActive;
  String createDate;
  int createById;
  String lastChanged;
  int lastChangedById;
  bool isDeleted;
  bool isSelected;

  Institute(
      {this.isAlreadyAdded,
        this.id,
        this.code,
        this.referralCode,
        this.name,
        this.shortName,
        this.longName,
        this.description,
        this.address1,
        this.address2,
        this.postcode,
        this.cityId,
        this.stateId,
        this.countryId,
        this.officeNumber,
        this.faxNumber,
        this.emailAddress,
        this.webUrl,
        this.logo,
        this.facebookUrl,
        this.instagramUrl,
        this.linkedInUrl,
        this.contactDetails,
        this.remarks,
        this.isActive,
        this.createDate,
        this.createById,
        this.lastChanged,
        this.lastChangedById,
        this.isDeleted,
        this.isSelected});

  Institute.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    code = json['Code'];
    referralCode = json['ReferralCode'];
    name = json['Name'];
    shortName = json['ShortName'];
    longName = json['LongName'];
    description = json['Description'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    postcode = json['Postcode'];
    cityId = json['CityId'];
    stateId = json['StateId'];
    countryId = json['CountryId'];
    officeNumber = json['OfficeNumber'];
    faxNumber = json['FaxNumber'];
    emailAddress = json['EmailAddress'];
    webUrl = json['WebUrl'];
    logo = json['Logo'];
    facebookUrl = json['FacebookUrl'];
    instagramUrl = json['InstagramUrl'];
    linkedInUrl = json['LinkedInUrl'];
    contactDetails = json['ContactDetails'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
    createDate = json['CreateDate'];
    createById = json['CreateById'];
    lastChanged = json['LastChanged'];
    lastChangedById = json['LastChangedById'];
    isDeleted = json['IsDeleted'];
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAlreadyAdded'] = this.isAlreadyAdded;
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['ReferralCode'] = this.referralCode;
    data['Name'] = this.name;
    data['ShortName'] = this.shortName;
    data['LongName'] = this.longName;
    data['Description'] = this.description;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['Postcode'] = this.postcode;
    data['CityId'] = this.cityId;
    data['StateId'] = this.stateId;
    data['CountryId'] = this.countryId;
    data['OfficeNumber'] = this.officeNumber;
    data['FaxNumber'] = this.faxNumber;
    data['EmailAddress'] = this.emailAddress;
    data['WebUrl'] = this.webUrl;
    data['Logo'] = this.logo;
    data['FacebookUrl'] = this.facebookUrl;
    data['InstagramUrl'] = this.instagramUrl;
    data['LinkedInUrl'] = this.linkedInUrl;
    data['ContactDetails'] = this.contactDetails;
    data['Remarks'] = this.remarks;
    data['IsActive'] = this.isActive;
    data['CreateDate'] = this.createDate;
    data['CreateById'] = this.createById;
    data['LastChanged'] = this.lastChanged;
    data['LastChangedById'] = this.lastChangedById;
    data['IsDeleted'] = this.isDeleted;
    data['IsSelected'] = this.isSelected;
    return data;
  }
}