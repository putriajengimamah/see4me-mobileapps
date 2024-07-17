// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    Data data;
    String status;

    ProfileModel({
        required this.data,
        required this.status,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    String email;
    String fullname;
    String id;

    Data({
        required this.email,
        required this.fullname,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        fullname: json["fullname"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "id": id,
    };
}
