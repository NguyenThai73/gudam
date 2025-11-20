import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class BillHistoryModel {
  int? id;
  String? createdDate;
  int? idBill;
  String? descriptionBill;
  int? status;
  BillHistoryModel({
    this.id,
    this.createdDate,
    this.idBill,
    this.descriptionBill,
    this.status,
  });


  BillHistoryModel copyWith({
    int? id,
    String? createdDate,
    int? idBill,
    String? descriptionBill,
    int? status,
  }) {
    return BillHistoryModel(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      idBill: idBill ?? this.idBill,
      descriptionBill: descriptionBill ?? this.descriptionBill,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdDate': createdDate,
      'idBill': idBill,
      'descriptionBill': descriptionBill,
      'status': status,
    };
  }

  factory BillHistoryModel.fromMap(Map<String, dynamic> map) {
    return BillHistoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdDate: map['createdDate'] != null ? map['createdDate'] as String : null,
      idBill: map['idBill'] != null ? map['idBill'] as int : null,
      descriptionBill: map['descriptionBill'] != null ? map['descriptionBill'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillHistoryModel.fromJson(String source) => BillHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
