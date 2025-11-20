// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_clock/service_clock.dart';

class ClockDetailCubitState extends Equatable {
  final ClockDetailStatus status;
  final ClockModel clockModel;
  final int numberBuy;
  const ClockDetailCubitState({
    required this.status,
    required this.clockModel,
    required this.numberBuy,
  });

  ClockDetailCubitState copyWith({
    ClockDetailStatus? status,
    ClockModel? clockModel,
    int? numberBuy,
  }) {
    return ClockDetailCubitState(
      status: status ?? this.status,
      clockModel: clockModel ?? this.clockModel,
      numberBuy: numberBuy ?? this.numberBuy,
    );
  }

  @override
  List<Object> get props => [status, clockModel, numberBuy, clockModel];
}

enum ClockDetailStatus { initial, loading, success, error }
