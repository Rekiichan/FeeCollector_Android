// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    this.image,
    this.idCar,
    this.type,
    this.date,
    this.time,
    this.timeM,
    this.location,
    this.latitude,
    this.longtitude,
    this.price,
    this.pendingStatus = false,
  });

  ObjectId id;
  String? image;
  String? idCar;
  String? type;
  String? date;
  String? time;
  String? timeM;
  String? location;
  double? latitude;
  double? longtitude;
  int? price;
  bool? pendingStatus;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    image: json["image"],
    idCar: json["idCar"],
    type: json["type"],
    date: json["date"],
    time: json["time"],
    timeM: json["timeM"],
    location: json["location"],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
    price: json["price"],
    pendingStatus: json["pendingStatus"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "idCar": idCar,
    "type": type,
    "date": date,
    "time": time,
    "timeM": timeM,
    "location": location,
    "latitude": latitude,
    "longtitude": longtitude,
    "price": price,
    "pendingStatus": pendingStatus,
  };
}
