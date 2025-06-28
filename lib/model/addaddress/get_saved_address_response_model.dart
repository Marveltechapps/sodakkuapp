import 'dart:convert';

GetSavedAddressResponse getSavedAddressResponseFromJson(String str) =>
    GetSavedAddressResponse.fromJson(json.decode(str));

String getSavedAddressResponseToJson(GetSavedAddressResponse data) =>
    json.encode(data.toJson());

class GetSavedAddressResponse {
  bool? success;
  List<SavedAddress>? data;

  GetSavedAddressResponse({
    this.success,
    this.data,
  });

  factory GetSavedAddressResponse.fromJson(Map<String, dynamic> json) =>
      GetSavedAddressResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SavedAddress>.from(
                json["data"]!.map((x) => SavedAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SavedAddress {
  Details? details;
  Coordinates? coordinates;
  String? id;
  String? userId;
  String? label;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  int? v;

  SavedAddress({
    this.details,
    this.coordinates,
    this.id,
    this.userId,
    this.label,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SavedAddress.fromJson(Map<String, dynamic> json) => SavedAddress(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
        id: json["_id"],
        userId: json["userId"],
        label: json["label"],
        isDefault: json["isDefault"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "details": details?.toJson(),
        "coordinates": coordinates?.toJson(),
        "_id": id,
        "userId": userId,
        "label": label,
        "isDefault": isDefault,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class Coordinates {
  dynamic latitude;
  dynamic longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Details {
  String? houseNo;
  String? building;
  String? landmark;
  String? area;
  String? city;
  String? state;
  String? pincode;

  Details({
    this.houseNo,
    this.building,
    this.landmark,
    this.area,
    this.city,
    this.state,
    this.pincode,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        houseNo: json["houseNo"],
        building: json["building"],
        landmark: json["landmark"],
        area: json["area"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "houseNo": houseNo,
        "building": building,
        "landmark": landmark,
        "area": area,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
