// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'clock.model.dart';

class CartItem {
  int? id;
  int? idClock;
  int? idUser;
  ClockModel? clock;
  int? number;
  CartItem({
    this.id,
    this.idClock,
    this.idUser,
    this.clock,
    this.number,
  });

  CartItem copyWith({
    int? id,
    int? idClock,
    int? idUser,
    ClockModel? clock,
    int? number,
  }) {
    return CartItem(
      id: id ?? this.id,
      idClock: idClock ?? this.idClock,
      idUser: idUser ?? this.idUser,
      clock: clock ?? this.clock,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idClock': idClock,
      'idUser': idUser,
      'number': number,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] != null ? map['id'] as int : null,
      idClock: map['idClock'] != null ? map['idClock'] as int : null,
      idUser: map['idUser'] != null ? map['idUser'] as int : null,
      clock: map['clock'] != null ? ClockModel.fromMap(map['clock'] as Map<String,dynamic>) : null,
      number: map['number'] != null ? map['number'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  int totalPoint() {
    int point = clock?.price ?? 0;
    int count = number ?? 0;
    return point * count;
  }
}
