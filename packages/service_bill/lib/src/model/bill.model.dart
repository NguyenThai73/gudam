// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:service_bill/src/model/bill.detail.model.dart';

class BillModel {
  int? id;
  int? idUser;
  String? createdDate;
  int? total;
  int? methodPayment;
  int? status;
  List<BillDetailModel> listDetail;
  BillModel({
    this.id,
    this.idUser,
    this.createdDate,
    this.total,
    this.methodPayment,
    this.status,
    required this.listDetail,
  });

  BillModel copyWith({
    int? id,
    int? idUser,
    String? createdDate,
    int? total,
    int? methodPayment,
    int? status,
    List<BillDetailModel>? listDetail,
  }) {
    return BillModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      createdDate: createdDate ?? this.createdDate,
      total: total ?? this.total,
      methodPayment: methodPayment ?? this.methodPayment,
      status: status ?? this.status,
      listDetail: listDetail ?? this.listDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'total': total,
      'methodPayment': methodPayment,
      'status': status,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
        id: map['id'] != null ? map['id'] as int : null,
        idUser: map['idUser'] != null ? map['idUser'] as int : null,
        createdDate: map['createdDate'] != null ? map['createdDate'] as String : null,
        total: map['total'] != null ? map['total'] as int : null,
        methodPayment: map['methodPayment'] != null ? map['methodPayment'] as int : null,
        status: map['status'] != null ? map['status'] as int : null,
        listDetail: []);
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) => BillModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
