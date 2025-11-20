import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/repository_clock.dart';
import 'search.cubit.state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final ClockRepository clockRepository;
  final TextEditingController searchController = TextEditingController();
  ClockTypeModel? clockTypeModel;
  SearchCubit({required this.clockRepository, this.clockTypeModel})
      : super(SearchCubitState(status: SearchStatus.initial, listHistoryFind: [], listClocks: [], clockTypeModel: clockTypeModel)) {
    getData();
  }
  getData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var listHistory = prefs.getStringList("history") ?? [];
    List<ClockModel> listData =
        await clockRepository.getListClock(name: searchController.text != "" ? searchController.text : null, idClockType: clockTypeModel?.id);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: listHistory, listClocks: listData));
  }

  findClock() async {
    addHistory(searchController.text);
    await getData();
  }

  findClockHistory(String findHistory) async {
    searchController.text = findHistory;
  }

  addHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (historyNew.isNotEmpty) {
      if (state.listHistoryFind.contains(historyNew)) {
      } else {
        state.listHistoryFind.insert(0, historyNew);
        prefs.setStringList("history", state.listHistoryFind);
      }
    }

    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }

  removeHistory(String historyNew) async {
    emit(state.copyWith(status: SearchStatus.initial));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state.listHistoryFind.remove(historyNew);
    prefs.setStringList("history", state.listHistoryFind);
    emit(state.copyWith(status: SearchStatus.success, listHistoryFind: state.listHistoryFind));
  }
}
