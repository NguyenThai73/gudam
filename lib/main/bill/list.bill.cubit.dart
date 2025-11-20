import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:app_dong_ho/repository/repository_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bill/service_bill.dart';

import 'list.bill.cubit.state.dart';

class ListBillCubit extends Cubit<ListBillCubitState> {
  final BillRepository billRepository;
  final AuthenticationRepository authenticationRepository;
  final PageController pageController = PageController();

  ListBillCubit(this.billRepository, this.authenticationRepository)
      : super(ListBillCubitState(status: ListBillStatus.initial, listBill: [], tabNumber: 0)) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: ListBillStatus.loading));
    List<BillModel> listBillGet = await billRepository.getListBill(idUser: authenticationRepository.currentUser?.id ?? 0, status: state.tabNumber);
    for (var element in listBillGet) {
      element.listDetail = await billRepository.getListBillDetail(idBill: element.id ?? 0);
    }
    emit(state.copyWith(status: ListBillStatus.success, listBill: listBillGet));
  }

  changePageNumber(int pageNumver) async {
    emit(state.copyWith(tabNumber: pageNumver));
    pageController.animateToPage(pageNumver, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    await Future.delayed(const Duration(milliseconds: 500));
    getData();
  }

  cancelBill(int index, String moTa) async {
    emit(state.copyWith(status: ListBillStatus.initial));
    await billRepository.updateBill(bill: state.listBill[index].copyWith(status: 3));
    await billRepository.updateHistoryBill(idBill: state.listBill[index].id, status: 3, moTa:moTa!=""?moTa:"Huỷ đơn hàng");
    state.listBill.removeAt(index);
    emit(state.copyWith(status: ListBillStatus.success, listBill: state.listBill));
  }

  receivedBill(int index) async {
    emit(state.copyWith(status: ListBillStatus.initial));
    await billRepository.updateBill(bill: state.listBill[index].copyWith(status: 2));
    await billRepository.updateHistoryBill(idBill: state.listBill[index].id, status: 2, moTa:"Đã nhận hàng.");
    state.listBill.removeAt(index);
    emit(state.copyWith(status: ListBillStatus.success, listBill: state.listBill));
  }
}
