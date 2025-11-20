// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:service_bill/service_bill.dart';

class BillHistoryCubitState extends Equatable {
  BillHistoryStatus status;
  BillModel billModel;
  List<BillHistoryModel> listHistory;

  BillHistoryCubitState({
    required this.status,
    required this.billModel,
    required this.listHistory,
  });

  BillHistoryCubitState copyWith({
    BillHistoryStatus? status,
    BillModel? billModel,
    List<BillHistoryModel>? listHistory,
  }) {
    return BillHistoryCubitState(
      status: status ?? this.status,
      billModel: billModel ?? this.billModel,
      listHistory: listHistory ?? this.listHistory,
    );
  }

  @override
  List<Object?> get props => [status, billModel, listHistory, listHistory.length];
}

enum BillHistoryStatus { initial, loading, success, error }
