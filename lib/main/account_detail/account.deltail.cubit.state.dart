// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class AccountDetailCubitState extends Equatable {
  final AccountDetailStatus status;
  final String avatar;
  final String fullName;
  final String sdt;
  final String address;
  final bool gender;

  const AccountDetailCubitState({
    required this.status,
    required this.avatar,
    required this.fullName,
    required this.sdt,
    required this.address,
    required this.gender,
  });

  AccountDetailCubitState copyWith({
    AccountDetailStatus? status,
    String? avatar,
    String? fullName,
    String? sdt,
    String? address,
    bool? gender,
  }) {
    return AccountDetailCubitState(
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      sdt: sdt ?? this.sdt,
      address: address ?? this.address,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object> get props => [status, avatar, fullName, sdt, address, gender];
}

enum AccountDetailStatus { initial, loading, success, error }
