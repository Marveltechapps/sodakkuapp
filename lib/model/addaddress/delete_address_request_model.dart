import 'dart:convert';

DeleteAddressRequest deleteAddressRequestFromJson(String str) => DeleteAddressRequest.fromJson(json.decode(str));

String deleteAddressRequestToJson(DeleteAddressRequest data) => json.encode(data.toJson());

class DeleteAddressRequest {
    String? label;
    DeleteDetails? deleteDetails;
    DCoordinates? dcoordinates;

    DeleteAddressRequest({
        this.label,
        this.deleteDetails,
        this.dcoordinates,
    });

    factory DeleteAddressRequest.fromJson(Map<String, dynamic> json) => DeleteAddressRequest(
        label: json["label"],
        deleteDetails: json["details"] == null ? null : DeleteDetails.fromJson(json["details"]),
        dcoordinates: json["coordinates"] == null ? null : DCoordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "details": deleteDetails?.toJson(),
        "coordinates": dcoordinates?.toJson(),
    };
}

class DCoordinates {
    double? latitude;
    double? longitude;

    DCoordinates({
        this.latitude,
        this.longitude,
    });

    factory DCoordinates.fromJson(Map<String, dynamic> json) => DCoordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class DeleteDetails {
    String? houseNo;
    String? building;
    String? landmark;
    String? area;
    String? city;
    String? state;
    String? pincode;

    DeleteDetails({
        this.houseNo,
        this.building,
        this.landmark,
        this.area,
        this.city,
        this.state,
        this.pincode,
    });

    factory DeleteDetails.fromJson(Map<String, dynamic> json) => DeleteDetails(
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
