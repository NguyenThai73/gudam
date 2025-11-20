import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';
import '../../../constants/list.load.state.dart';

class ClockTypeCubit extends Cubit<ListLoadState<ClockTypeModel>> {
  final ClockRepository clockRepository;
  final ScrollController scrollController = ScrollController();

  ClockTypeCubit({required this.clockRepository}) : super(const ListLoadState()) {
    getData();
    scrollController.addListener(_onScroll);
  }
  getData() async{
    emit(state.copyWith(status: ListLoadStatus.loading));
    List<ClockTypeModel> listClockType = await clockRepository.getListClockType();
    emit(state.copyWith(status: ListLoadStatus.loadmore, list: listClockType));
  }

  Future<void> _onScroll() async {}
}
