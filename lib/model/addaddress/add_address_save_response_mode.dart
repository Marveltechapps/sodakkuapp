import 'dart:convert';

AddAddressSaveResponse addAddressSaveResponseFromJson(String str) => AddAddressSaveResponse.fromJson(json.decode(str));

String addAddressSaveResponseToJson(AddAddressSaveResponse data) => json.encode(data.toJson());

class AddAddressSaveResponse {
    bool? success;
    String? message;
    Data? data;

    AddAddressSaveResponse({
        this.success,
        this.message,
        this.data,
    });

    factory AddAddressSaveResponse.fromJson(Map<String, dynamic> json) => AddAddressSaveResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? userId;
    String? label;
    Details? details;
    Coordinates? coordinates;
    bool? isDefault;
    String? id;
    String? createdAt;
    String? updatedAt;
    int? v;

    Data({
        this.userId,
        this.label,
        this.details,
        this.coordinates,
        this.isDefault,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        label: json["label"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
        isDefault: json["isDefault"],
        id: json["_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "label": label,
        "details": details?.toJson(),
        "coordinates": coordinates?.toJson(),
        "isDefault": isDefault,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}

class Coordinates {
    double? latitude;
    double? longitude;

    Coordinates({
        this.latitude,
        this.longitude,
    });

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
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
