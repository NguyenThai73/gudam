// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_clock/service_clock.dart';

class BillDetailModel {
  int? id;
  int? idClock;
  int? idBill;
  ClockModel? clock;
  int? number;
  BillDetailModel({
    this.id,
    this.idClock,
    this.idBill,
    this.clock,
    this.number,
  });

  BillDetailModel copyWith({
    int? id,
    int? idClock,
    int? idBill,
    ClockModel? clock,
    int? number,
  }) {
    return BillDetailModel(
      id: id ?? this.id,
      idClock: idClock ?? this.idClock,
      idBill: idBill ?? this.idBill,
      clock: clock ?? this.clock,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idClock': idClock,
      'idBill': idBill,
      'number': number,
    };
  }

  factory BillDetailModel.fromMap(Map<String, dynamic> map) {
    return BillDetailModel(
      id: map['id'] != null ? map['id'] as int : null,
      idClock: map['idClock'] != null ? map['idClock'] as int : null,
      idBill: map['idBill'] != null ? map['idBill'] as int : null,
      clock: map['clock'] != null ? ClockModel.fromMap(map['clock'] as Map<String, dynamic>) : null,
      number: map['number'] != null ? map['number'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillDetailModel.fromJson(String source) => BillDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  int totalPoint() {
    var pointClock = clock?.price ?? 0;
    var numberClock = number ?? 0;
    return pointClock * numberClock;
  }
}
