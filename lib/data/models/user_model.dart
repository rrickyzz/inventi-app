// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? uid;
    String? email;
    String? firstName;
    String? lastName;
    String? userType;

    UserModel({
        this.uid,
        this.email,
        this.firstName,
        this.lastName,
        this.userType,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userType: json["userType"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userType": userType,
    };
}
