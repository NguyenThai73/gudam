import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';

import '../../repository/repository_clock.dart';
import 'clock.detail.cubit.state.dart';

class ClockDetailCubit extends Cubit<ClockDetailCubitState> {
  final ClockRepository clockRepository;
  final ClockModel clockModel;

  ClockDetailCubit({required this.clockRepository, required this.clockModel})
      : super(ClockDetailCubitState(status: ClockDetailStatus.initial, clockModel: clockModel, numberBuy: 0)) {
    getData();
  }
  getData() async {
    print(clockModel.toMap());
  }

  void removeNumberBuy() {
    if (state.numberBuy > 0) {
      emit(state.copyWith(numberBuy: state.numberBuy - 1));
    }
  }

  void addNumberBuy() {
    emit(state.copyWith(numberBuy: state.numberBuy + 1));
  }

  void resetNumberBuy() {
    emit(state.copyWith(numberBuy: 0));
  }
}
