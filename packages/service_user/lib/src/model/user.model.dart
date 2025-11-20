// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  int? role;
  String? email;
  String? password;
  String? address;
  String? fullName;
  bool? gioiTinh;
  String? avatar;
  String? sdt;
  UserModel({
    this.id,
    this.role,
    this.email,
    this.password,
    this.address,
    this.fullName,
    this.gioiTinh,
    this.avatar,
    this.sdt,
  });
  UserModel copyWith({
    int? id,
    int? role,
    String? email,
    String? password,
    String? address,
    String? fullName,
    bool? gioiTinh,
    String? avatar,
    String? sdt,
  }) {
    return UserModel(
      id: id ?? this.id,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      fullName: fullName ?? this.fullName,
      gioiTinh: gioiTinh ?? this.gioiTinh,
      avatar: avatar ?? this.avatar,
      sdt: sdt ?? this.sdt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'email': email,
      'password': password,
      'address': address,
      'fullName': fullName,
      'gioiTinh': gioiTinh,
      'avatar': avatar,
      'sdt': sdt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      role: map['role'] != null ? map['role'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      gioiTinh: map['gioiTinh'] != null ? map['gioiTinh'] as bool : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      sdt: map['sdt'] != null ? map['sdt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

}
