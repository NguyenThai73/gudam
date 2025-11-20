// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'clock.type.model.dart';

class ClockModel {
  final int? id;
  final int? idclockType;
  final ClockTypeModel? clockType;
  final String? name;
  final String? image;
  final String? descriptionDecor;
  final int? price;
  final int? quantity;
  final int? status;
 ClockModel({
    this.id,
    this.idclockType,
    this.clockType,
    this.name,
    this.image,
    this.descriptionDecor,
    this.price,
    this.quantity,
    this.status,
  });

 ClockModel copyWith({
    int? id,
    int? idclockType,
    ClockTypeModel? clockType,
    String? name,
    String? image,
    String? descriptionDecor,
    int? price,
    int? quantity,
    int? status,
  }) {
    return ClockModel(
      id: id ?? this.id,
      idclockType: idclockType ?? this.idclockType,
      clockType: clockType ?? this.clockType,
      name: name ?? this.name,
      image: image ?? this.image,
      descriptionDecor: descriptionDecor ?? this.descriptionDecor,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idClockType': idclockType,
      'name': name,
      'image': image,
      'descriptionDecor': descriptionDecor,
      'price': price,
      'quantity': quantity,
      'status': status,
    };
  }

  factory ClockModel.fromMap(Map<String, dynamic> map) {
    return ClockModel(
      id: map['id'] != null ? map['id'] as int : null,
      idclockType: map['idclockType'] != null ? map['idclockType'] as int : null,
      clockType: map['clockType'] != null ? ClockTypeModel.fromMap(map['clockType'] as Map<String, dynamic>) : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      descriptionDecor: map['descriptionDecor'] != null ? map['descriptionDecor'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClockModel.fromJson(String source) => ClockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  List<String> listImage() {
    if (image != null && image != "") {
      return image!.split(',');
    } else {
      return [];
    }
  }
}
