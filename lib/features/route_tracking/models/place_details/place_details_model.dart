class PlaceDetailsModel {
  String? name;
  String? id;
  List<String>? types;
  String? nationalPhoneNumber;
  String? internationalPhoneNumber;
  String? formattedAddress;
  List<AddressComponentsModel>? addressComponents;
  PlusCodeModel? plusCode;
  LocationModel? location;
  ViewportModel? viewport;
  double? rating;
  String? googleMapsUri;
  String? websiteUri;
  RegularOpeningHoursModel? regularOpeningHours;
  int? utcOffsetMinutes;
  String? adrFormatAddress;
  String? businessStatus;
  int? userRatingCount;
  String? iconMaskBaseUri;
  String? iconBackgroundColor;
  DisplayNameModel? displayName;
  DisplayNameModel? primaryTypeDisplayName;
  RegularOpeningHoursModel? currentOpeningHours;
  String? primaryType;
  String? shortFormattedAddress;
  DisplayNameModel? editorialSummary;
  List<ReviewsModel>? reviews;
  List<PhotosModel>? photos;
  AccessibilityOptionsModel? accessibilityOptions;
  bool? pureServiceAreaBusiness;
  AddressDescriptorModel? addressDescriptor;
  GoogleMapsLinksModel? googleMapsLinks;
  TimeZoneModel? timeZone;
  PostalAddressModel? postalAddress;

  PlaceDetailsModel({
    this.name,
    this.id,
    this.types,
    this.nationalPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.addressComponents,
    this.plusCode,
    this.location,
    this.viewport,
    this.rating,
    this.googleMapsUri,
    this.websiteUri,
    this.regularOpeningHours,
    this.utcOffsetMinutes,
    this.adrFormatAddress,
    this.businessStatus,
    this.userRatingCount,
    this.iconMaskBaseUri,
    this.iconBackgroundColor,
    this.displayName,
    this.primaryTypeDisplayName,
    this.currentOpeningHours,
    this.primaryType,
    this.shortFormattedAddress,
    this.editorialSummary,
    this.reviews,
    this.photos,
    this.accessibilityOptions,
    this.pureServiceAreaBusiness,
    this.addressDescriptor,
    this.googleMapsLinks,
    this.timeZone,
    this.postalAddress,
  });

  PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    types = json['types'].cast<String>();
    nationalPhoneNumber = json['nationalPhoneNumber'];
    internationalPhoneNumber = json['internationalPhoneNumber'];
    formattedAddress = json['formattedAddress'];
    if (json['addressComponents'] != null) {
      addressComponents = <AddressComponentsModel>[];
      json['addressComponents'].forEach((v) {
        addressComponents!.add(new AddressComponentsModel.fromJson(v));
      });
    }
    plusCode = json['plusCode'] != null
        ? new PlusCodeModel.fromJson(json['plusCode'])
        : null;
    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new ViewportModel.fromJson(json['viewport'])
        : null;
    rating = json['rating'].runtimeType == int
        ? json['rating'].toDouble()
        : null;

    googleMapsUri = json['googleMapsUri'];
    websiteUri = json['websiteUri'];
    regularOpeningHours = json['regularOpeningHours'] != null
        ? new RegularOpeningHoursModel.fromJson(json['regularOpeningHours'])
        : null;
    utcOffsetMinutes = json['utcOffsetMinutes'];
    adrFormatAddress = json['adrFormatAddress'];
    businessStatus = json['businessStatus'];
    userRatingCount = json['userRatingCount'];
    iconMaskBaseUri = json['iconMaskBaseUri'];
    iconBackgroundColor = json['iconBackgroundColor'];
    displayName = json['displayName'] != null
        ? new DisplayNameModel.fromJson(json['displayName'])
        : null;
    primaryTypeDisplayName = json['primaryTypeDisplayName'] != null
        ? new DisplayNameModel.fromJson(json['primaryTypeDisplayName'])
        : null;
    currentOpeningHours = json['currentOpeningHours'] != null
        ? new RegularOpeningHoursModel.fromJson(json['currentOpeningHours'])
        : null;
    primaryType = json['primaryType'];
    shortFormattedAddress = json['shortFormattedAddress'];
    editorialSummary = json['editorialSummary'] != null
        ? new DisplayNameModel.fromJson(json['editorialSummary'])
        : null;
    if (json['reviews'] != null) {
      reviews = <ReviewsModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ReviewsModel.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = <PhotosModel>[];
      json['photos'].forEach((v) {
        photos!.add(new PhotosModel.fromJson(v));
      });
    }
    accessibilityOptions = json['accessibilityOptions'] != null
        ? new AccessibilityOptionsModel.fromJson(json['accessibilityOptions'])
        : null;
    pureServiceAreaBusiness = json['pureServiceAreaBusiness'];
    addressDescriptor = json['addressDescriptor'] != null
        ? new AddressDescriptorModel.fromJson(json['addressDescriptor'])
        : null;
    googleMapsLinks = json['googleMapsLinks'] != null
        ? new GoogleMapsLinksModel.fromJson(json['googleMapsLinks'])
        : null;
    timeZone = json['timeZone'] != null
        ? new TimeZoneModel.fromJson(json['timeZone'])
        : null;
    postalAddress = json['postalAddress'] != null
        ? new PostalAddressModel.fromJson(json['postalAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['types'] = this.types;
    data['nationalPhoneNumber'] = this.nationalPhoneNumber;
    data['internationalPhoneNumber'] = this.internationalPhoneNumber;
    data['formattedAddress'] = this.formattedAddress;
    if (this.addressComponents != null) {
      data['addressComponents'] = this.addressComponents!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.plusCode != null) {
      data['plusCode'] = this.plusCode!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    data['rating'] = this.rating;
    data['googleMapsUri'] = this.googleMapsUri;
    data['websiteUri'] = this.websiteUri;
    if (this.regularOpeningHours != null) {
      data['regularOpeningHours'] = this.regularOpeningHours!.toJson();
    }
    data['utcOffsetMinutes'] = this.utcOffsetMinutes;
    data['adrFormatAddress'] = this.adrFormatAddress;
    data['businessStatus'] = this.businessStatus;
    data['userRatingCount'] = this.userRatingCount;
    data['iconMaskBaseUri'] = this.iconMaskBaseUri;
    data['iconBackgroundColor'] = this.iconBackgroundColor;
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    if (this.primaryTypeDisplayName != null) {
      data['primaryTypeDisplayName'] = this.primaryTypeDisplayName!.toJson();
    }
    if (this.currentOpeningHours != null) {
      data['currentOpeningHours'] = this.currentOpeningHours!.toJson();
    }
    data['primaryType'] = this.primaryType;
    data['shortFormattedAddress'] = this.shortFormattedAddress;
    if (this.editorialSummary != null) {
      data['editorialSummary'] = this.editorialSummary!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    if (this.accessibilityOptions != null) {
      data['accessibilityOptions'] = this.accessibilityOptions!.toJson();
    }
    data['pureServiceAreaBusiness'] = this.pureServiceAreaBusiness;
    if (this.addressDescriptor != null) {
      data['addressDescriptor'] = this.addressDescriptor!.toJson();
    }
    if (this.googleMapsLinks != null) {
      data['googleMapsLinks'] = this.googleMapsLinks!.toJson();
    }
    if (this.timeZone != null) {
      data['timeZone'] = this.timeZone!.toJson();
    }
    if (this.postalAddress != null) {
      data['postalAddress'] = this.postalAddress!.toJson();
    }
    return data;
  }
}

class AddressComponentsModel {
  String? longText;
  String? shortText;
  List<String>? types;
  String? languageCode;

  AddressComponentsModel({
    this.longText,
    this.shortText,
    this.types,
    this.languageCode,
  });

  AddressComponentsModel.fromJson(Map<String, dynamic> json) {
    longText = json['longText'];
    shortText = json['shortText'];
    types = json['types'].cast<String>();
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longText'] = this.longText;
    data['shortText'] = this.shortText;
    data['types'] = this.types;
    data['languageCode'] = this.languageCode;
    return data;
  }
}

class PlusCodeModel {
  String? globalCode;
  String? compoundCode;

  PlusCodeModel({this.globalCode, this.compoundCode});

  PlusCodeModel.fromJson(Map<String, dynamic> json) {
    globalCode = json['globalCode'];
    compoundCode = json['compoundCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['globalCode'] = this.globalCode;
    data['compoundCode'] = this.compoundCode;
    return data;
  }
}

class LocationModel {
  double? latitude;
  double? longitude;

  LocationModel({this.latitude, this.longitude});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ViewportModel {
  LocationModel? low;
  LocationModel? high;

  ViewportModel({this.low, this.high});

  ViewportModel.fromJson(Map<String, dynamic> json) {
    low = json['low'] != null ? new LocationModel.fromJson(json['low']) : null;
    high = json['high'] != null
        ? new LocationModel.fromJson(json['high'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.low != null) {
      data['low'] = this.low!.toJson();
    }
    if (this.high != null) {
      data['high'] = this.high!.toJson();
    }
    return data;
  }
}

class RegularOpeningHoursModel {
  bool? openNow;
  List<PeriodsModel>? periods;
  List<String>? weekdayDescriptions;
  String? nextOpenTime;

  RegularOpeningHoursModel({
    this.openNow,
    this.periods,
    this.weekdayDescriptions,
    this.nextOpenTime,
  });

  RegularOpeningHoursModel.fromJson(Map<String, dynamic> json) {
    openNow = json['openNow'];
    if (json['periods'] != null) {
      periods = <PeriodsModel>[];
      json['periods'].forEach((v) {
        periods!.add(new PeriodsModel.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
    nextOpenTime = json['nextOpenTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openNow'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = this.weekdayDescriptions;
    data['nextOpenTime'] = this.nextOpenTime;
    return data;
  }
}

class PeriodsModel {
  OpenModel? open;
  OpenModel? close;

  PeriodsModel({this.open, this.close});

  PeriodsModel.fromJson(Map<String, dynamic> json) {
    open = json['open'] != null ? new OpenModel.fromJson(json['open']) : null;
    close = json['close'] != null
        ? new OpenModel.fromJson(json['close'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    if (this.close != null) {
      data['close'] = this.close!.toJson();
    }
    return data;
  }
}

class DisplayNameModel {
  String? text;
  String? languageCode;

  DisplayNameModel({this.text, this.languageCode});

  DisplayNameModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['languageCode'] = this.languageCode;
    return data;
  }
}

class OpenModel {
  int? day;
  int? hour;
  int? minute;
  DateModel? date;

  OpenModel({this.day, this.hour, this.minute, this.date});

  OpenModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
    date = json['date'] != null ? new DateModel.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    return data;
  }
}

class DateModel {
  int? year;
  int? month;
  int? day;

  DateModel({this.year, this.month, this.day});

  DateModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class ReviewsModel {
  String? name;
  String? relativePublishTimeDescription;
  int? rating;
  DisplayNameModel? text;
  DisplayNameModel? originalText;
  AuthorAttributionModel? authorAttribution;
  String? publishTime;
  String? flagContentUri;
  String? googleMapsUri;

  ReviewsModel({
    this.name,
    this.relativePublishTimeDescription,
    this.rating,
    this.text,
    this.originalText,
    this.authorAttribution,
    this.publishTime,
    this.flagContentUri,
    this.googleMapsUri,
  });

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    relativePublishTimeDescription = json['relativePublishTimeDescription'];
    rating = json['rating'];
    text = json['text'] != null
        ? new DisplayNameModel.fromJson(json['text'])
        : null;
    originalText = json['originalText'] != null
        ? new DisplayNameModel.fromJson(json['originalText'])
        : null;
    authorAttribution = json['authorAttribution'] != null
        ? new AuthorAttributionModel.fromJson(json['authorAttribution'])
        : null;
    publishTime = json['publishTime'];
    flagContentUri = json['flagContentUri'];
    googleMapsUri = json['googleMapsUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['relativePublishTimeDescription'] =
        this.relativePublishTimeDescription;
    data['rating'] = this.rating;
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    if (this.originalText != null) {
      data['originalText'] = this.originalText!.toJson();
    }
    if (this.authorAttribution != null) {
      data['authorAttribution'] = this.authorAttribution!.toJson();
    }
    data['publishTime'] = this.publishTime;
    data['flagContentUri'] = this.flagContentUri;
    data['googleMapsUri'] = this.googleMapsUri;
    return data;
  }
}

class AuthorAttributionModel {
  String? displayName;
  String? uri;
  String? photoUri;

  AuthorAttributionModel({this.displayName, this.uri, this.photoUri});

  AuthorAttributionModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    uri = json['uri'];
    photoUri = json['photoUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['uri'] = this.uri;
    data['photoUri'] = this.photoUri;
    return data;
  }
}

class PhotosModel {
  String? name;
  int? widthPx;
  int? heightPx;
  List<AuthorAttributionModel>? authorAttributions;
  String? flagContentUri;
  String? googleMapsUri;

  PhotosModel({
    this.name,
    this.widthPx,
    this.heightPx,
    this.authorAttributions,
    this.flagContentUri,
    this.googleMapsUri,
  });

  PhotosModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    widthPx = json['widthPx'];
    heightPx = json['heightPx'];
    if (json['authorAttributions'] != null) {
      authorAttributions = <AuthorAttributionModel>[];
      json['authorAttributions'].forEach((v) {
        authorAttributions!.add(new AuthorAttributionModel.fromJson(v));
      });
    }
    flagContentUri = json['flagContentUri'];
    googleMapsUri = json['googleMapsUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['widthPx'] = this.widthPx;
    data['heightPx'] = this.heightPx;
    if (this.authorAttributions != null) {
      data['authorAttributions'] = this.authorAttributions!
          .map((v) => v.toJson())
          .toList();
    }
    data['flagContentUri'] = this.flagContentUri;
    data['googleMapsUri'] = this.googleMapsUri;
    return data;
  }
}

class AccessibilityOptionsModel {
  bool? wheelchairAccessibleEntrance;

  AccessibilityOptionsModel({this.wheelchairAccessibleEntrance});

  AccessibilityOptionsModel.fromJson(Map<String, dynamic> json) {
    wheelchairAccessibleEntrance = json['wheelchairAccessibleEntrance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wheelchairAccessibleEntrance'] = this.wheelchairAccessibleEntrance;
    return data;
  }
}

class AddressDescriptorModel {
  List<LandmarksModel>? landmarks;
  List<AreasModel>? areas;

  AddressDescriptorModel({this.landmarks, this.areas});

  AddressDescriptorModel.fromJson(Map<String, dynamic> json) {
    if (json['landmarks'] != null) {
      landmarks = <LandmarksModel>[];
      json['landmarks'].forEach((v) {
        landmarks!.add(new LandmarksModel.fromJson(v));
      });
    }
    if (json['areas'] != null) {
      areas = <AreasModel>[];
      json['areas'].forEach((v) {
        areas!.add(new AreasModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.landmarks != null) {
      data['landmarks'] = this.landmarks!.map((v) => v.toJson()).toList();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LandmarksModel {
  String? name;
  String? placeId;
  DisplayNameModel? displayName;
  List<String>? types;
  double? straightLineDistanceMeters;
  double? travelDistanceMeters;
  String? spatialRelationship;

  LandmarksModel({
    this.name,
    this.placeId,
    this.displayName,
    this.types,
    this.straightLineDistanceMeters,
    this.travelDistanceMeters,
    this.spatialRelationship,
  });

  LandmarksModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['placeId'];
    displayName = json['displayName'] != null
        ? new DisplayNameModel.fromJson(json['displayName'])
        : null;
    types = json['types'].cast<String>();
    straightLineDistanceMeters = json['straightLineDistanceMeters'];
    travelDistanceMeters = json['travelDistanceMeters'];
    spatialRelationship = json['spatialRelationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['placeId'] = this.placeId;
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    data['types'] = this.types;
    data['straightLineDistanceMeters'] = this.straightLineDistanceMeters;
    data['travelDistanceMeters'] = this.travelDistanceMeters;
    data['spatialRelationship'] = this.spatialRelationship;
    return data;
  }
}

class AreasModel {
  String? name;
  String? placeId;
  DisplayNameModel? displayName;
  String? containment;

  AreasModel({this.name, this.placeId, this.displayName, this.containment});

  AreasModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['placeId'];
    displayName = json['displayName'] != null
        ? new DisplayNameModel.fromJson(json['displayName'])
        : null;
    containment = json['containment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['placeId'] = this.placeId;
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    data['containment'] = this.containment;
    return data;
  }
}

class GoogleMapsLinksModel {
  String? directionsUri;
  String? placeUri;
  String? writeAReviewUri;
  String? reviewsUri;
  String? photosUri;

  GoogleMapsLinksModel({
    this.directionsUri,
    this.placeUri,
    this.writeAReviewUri,
    this.reviewsUri,
    this.photosUri,
  });

  GoogleMapsLinksModel.fromJson(Map<String, dynamic> json) {
    directionsUri = json['directionsUri'];
    placeUri = json['placeUri'];
    writeAReviewUri = json['writeAReviewUri'];
    reviewsUri = json['reviewsUri'];
    photosUri = json['photosUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directionsUri'] = this.directionsUri;
    data['placeUri'] = this.placeUri;
    data['writeAReviewUri'] = this.writeAReviewUri;
    data['reviewsUri'] = this.reviewsUri;
    data['photosUri'] = this.photosUri;
    return data;
  }
}

class TimeZoneModel {
  String? id;

  TimeZoneModel({this.id});

  TimeZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class PostalAddressModel {
  String? regionCode;
  String? languageCode;
  String? postalCode;
  String? administrativeArea;
  String? locality;
  List<String>? addressLines;

  PostalAddressModel({
    this.regionCode,
    this.languageCode,
    this.postalCode,
    this.administrativeArea,
    this.locality,
    this.addressLines,
  });

  PostalAddressModel.fromJson(Map<String, dynamic> json) {
    regionCode = json['regionCode'];
    languageCode = json['languageCode'];
    postalCode = json['postalCode'];
    administrativeArea = json['administrativeArea'];
    locality = json['locality'];
    addressLines = json['addressLines'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regionCode'] = this.regionCode;
    data['languageCode'] = this.languageCode;
    data['postalCode'] = this.postalCode;
    data['administrativeArea'] = this.administrativeArea;
    data['locality'] = this.locality;
    data['addressLines'] = this.addressLines;
    return data;
  }
}
