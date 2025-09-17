// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  int? currentNumberOfPeople;
  String? location;
  int? currentGarbage;
  bool? private;
  String? streamUrl;

  LocationModel({
    this.currentNumberOfPeople,
    this.location,
    this.currentGarbage,
    this.private,
    this.streamUrl,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        currentNumberOfPeople: json["currentNumberOfPeople"],
        location: json["location"],
        currentGarbage: json["currentGarbage"],
        private: json["private"],
        streamUrl: json["stream_url"],
      );

  Map<String, dynamic> toJson() => {
        "currentNumberOfPeople": currentNumberOfPeople,
        "location": location,
        "currentGarbage": currentGarbage,
        "private": private,
        "stream_url": streamUrl,
      };
}
