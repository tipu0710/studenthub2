class HomeModel {
  List<ChannelList> channelList;
  List<EventList> eventList;
  GeneralInstitute institute;
  List<AnnouncementList> announcementList;
  List<AddList> addList;

  HomeModel(
      {this.channelList,
        this.eventList,
        this.institute,
        this.announcementList,
        this.addList});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['channelList'] != null) {
      channelList = <ChannelList>[];
      json['channelList'].forEach((v) {
        channelList.add(new ChannelList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = <EventList>[];
      json['eventList'].forEach((v) {
        eventList.add(new EventList.fromJson(v));
      });
    }
    institute = json['institute'] != null
        ? new GeneralInstitute.fromJson(json['institute'])
        : null;
    if (json['announcementList'] != null) {
      announcementList = <AnnouncementList>[];
      json['announcementList'].forEach((v) {
        announcementList.add(new AnnouncementList.fromJson(v));
      });
    }
    if (json['addList'] != null) {
      addList = <AddList>[];
      json['addList'].forEach((v) {
        addList.add(new AddList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channelList != null) {
      data['channelList'] = this.channelList.map((v) => v.toJson()).toList();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList.map((v) => v.toJson()).toList();
    }
    if (this.institute != null) {
      data['institute'] = this.institute.toJson();
    }
    if (this.announcementList != null) {
      data['announcementList'] =
          this.announcementList.map((v) => v.toJson()).toList();
    }
    if (this.addList != null) {
      data['addList'] = this.addList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChannelList {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  GeneralInstitute generalInstitute;
  bool isSelected;

  ChannelList(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.generalInstitute,
        this.isSelected});

  ChannelList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
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
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    if (this.generalInstitute != null) {
      data['General_Institute'] = this.generalInstitute.toJson();
    }
    data['IsSelected'] = this.isSelected;
    return data;
  }
}

class GeneralInstitute {
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

  GeneralInstitute(
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

  GeneralInstitute.fromJson(Map<String, dynamic> json) {
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

class AdminChannel {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  AdminChannel(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  AdminChannel.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
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
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
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

class AdminEvent {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  int channelId;
  String dateFrom;
  String dateTo;
  String description;
  String image;
  bool isMeritPoint;
  int meritPoint;
  String qRCode;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  AdminEvent(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.channelId,
        this.dateFrom,
        this.dateTo,
        this.description,
        this.image,
        this.isMeritPoint,
        this.meritPoint,
        this.qRCode,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  AdminEvent.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    channelId = json['ChannelId'];
    dateFrom = json['DateFrom'];
    dateTo = json['DateTo'];
    description = json['Description'];
    image = json['Image'];
    isMeritPoint = json['IsMeritPoint'];
    meritPoint = json['MeritPoint'];
    qRCode = json['QRCode'];
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
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['ChannelId'] = this.channelId;
    data['DateFrom'] = this.dateFrom;
    data['DateTo'] = this.dateTo;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['IsMeritPoint'] = this.isMeritPoint;
    data['MeritPoint'] = this.meritPoint;
    data['QRCode'] = this.qRCode;
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

class EventList {
  bool isAlreadyAdded;
  int id;
  int instituteId;
  String code;
  String name;
  int channelId;
  String dateFrom;
  String dateTo;
  String description;
  String image;
  bool isMeritPoint;
  double meritPoint;
  String qRCode;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  EventList(
      {this.isAlreadyAdded,
        this.id,
        this.instituteId,
        this.code,
        this.name,
        this.channelId,
        this.dateFrom,
        this.dateTo,
        this.description,
        this.image,
        this.isMeritPoint,
        this.meritPoint,
        this.qRCode,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  EventList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    instituteId = json['InstituteId'];
    code = json['Code'];
    name = json['Name'];
    channelId = json['ChannelId'];
    dateFrom = json['DateFrom'];
    dateTo = json['DateTo'];
    description = json['Description'];
    image = json['Image'];
    isMeritPoint = json['IsMeritPoint'];
    meritPoint = json['MeritPoint'];
    qRCode = json['QRCode'];
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
    data['InstituteId'] = this.instituteId;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['ChannelId'] = this.channelId;
    data['DateFrom'] = this.dateFrom;
    data['DateTo'] = this.dateTo;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['IsMeritPoint'] = this.isMeritPoint;
    data['MeritPoint'] = this.meritPoint;
    data['QRCode'] = this.qRCode;
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

class AnnouncementList {
  int id;
  int instituteId;
  String title;
  String description;
  String image;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;

  AnnouncementList(
      {this.id,
        this.instituteId,
        this.title,
        this.description,
        this.image,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted});

  AnnouncementList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    instituteId = json['InstituteId'];
    title = json['Title'];
    description = json['Description'];
    image = json['Image'];
    isActive = json['IsActive'];
    createById = json['CreateById'];
    createDate = json['CreateDate'];
    lastChangedById = json['LastChangedById'];
    lastChanged = json['LastChanged'];
    isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['InstituteId'] = this.instituteId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['IsActive'] = this.isActive;
    data['CreateById'] = this.createById;
    data['CreateDate'] = this.createDate;
    data['LastChangedById'] = this.lastChangedById;
    data['LastChanged'] = this.lastChanged;
    data['IsDeleted'] = this.isDeleted;
    return data;
  }
}

class AddList {
  bool isAlreadyAdded;
  int id;
  String name;
  String link;
  String image;
  int sortingOrder;
  bool isActive;
  int createById;
  String createDate;
  int lastChangedById;
  String lastChanged;
  bool isDeleted;
  bool isSelected;

  AddList(
      {this.isAlreadyAdded,
        this.id,
        this.name,
        this.link,
        this.image,
        this.sortingOrder,
        this.isActive,
        this.createById,
        this.createDate,
        this.lastChangedById,
        this.lastChanged,
        this.isDeleted,
        this.isSelected});

  AddList.fromJson(Map<String, dynamic> json) {
    isAlreadyAdded = json['IsAlreadyAdded'];
    id = json['Id'];
    name = json['Name'];
    link = json['Link'];
    image = json['Image'];
    sortingOrder = json['SortingOrder'];
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
    data['Name'] = this.name;
    data['Link'] = this.link;
    data['Image'] = this.image;
    data['SortingOrder'] = this.sortingOrder;
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