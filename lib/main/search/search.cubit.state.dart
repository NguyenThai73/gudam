// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_clock/service_clock.dart';

class SearchCubitState extends Equatable {
  SearchStatus status;
  List<String> listHistoryFind;
  List<ClockModel> listClocks;
  ClockTypeModel? clockTypeModel;
  SearchCubitState({
    required this.status,
    required this.listHistoryFind,
    required this.listClocks,
    this.clockTypeModel,
  });

  SearchCubitState copyWith({
    SearchStatus? status,
    List<String>? listHistoryFind,
    List<ClockModel>? listClocks,
    ClockTypeModel? clockTypeModel,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      listHistoryFind: listHistoryFind ?? this.listHistoryFind,
      listClocks: listClocks ?? this.listClocks,
      clockTypeModel: clockTypeModel ?? this.clockTypeModel,
    );
  }

  @override
  List<Object?> get props => [status, listHistoryFind, listHistoryFind.length, listClocks, listClocks.length, clockTypeModel];
}

enum SearchStatus { initial, loading, success, error }
