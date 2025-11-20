// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:service_bill/service_bill.dart';

class BillDetailCubitState extends Equatable {
  BillDEtailStatus status;
  BillModel billModel;

  BillDetailCubitState({
    required this.status,
    required this.billModel,
  });

  BillDetailCubitState copyWith({
    BillDEtailStatus? status,
    BillModel? billModel,
  }) {
    return BillDetailCubitState(
      status: status ?? this.status,
      billModel: billModel ?? this.billModel,
    );
  }

  @override
  List<Object?> get props => [status, billModel];
}

enum BillDEtailStatus { initial, loading, success, error }
