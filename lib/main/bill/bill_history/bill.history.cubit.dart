import 'package:app_dong_ho/repository/repository_bill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bill/service_bill.dart';

import 'bill.history.cubit.state.dart';

class BillHistoryCubit extends Cubit<BillHistoryCubitState> {
  final BillRepository billRepository;
  final BillModel billModel;

  BillHistoryCubit({required this.billRepository, required this.billModel})
      : super(BillHistoryCubitState(status: BillHistoryStatus.initial, billModel: billModel, listHistory: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: BillHistoryStatus.loading));
    var listHistoryGet = await billRepository.getListBillHistory(idBill: billModel.id ?? 0);
    emit(state.copyWith(status: BillHistoryStatus.success, listHistory: listHistoryGet));
  }
}
