import 'package:app_dong_ho/main/cart/cart.page.dart';
import 'package:app_dong_ho/repository/repository_bill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment.cubit.state.dart';

class PaymentCubit extends Cubit<PaymentCubitState> {
  final BillRepository billRepository;
  final DataSendBill dataSendBill;

  PaymentCubit({required this.billRepository, required this.dataSendBill})
      : super(PaymentCubitState(status: PaymentStatus.initial, billModel: dataSendBill.billModel)) {
    getData();
  }
  getData() async {}

  void buyClock() async {
    emit(state.copyWith(status: PaymentStatus.loading));
    var reponseCreateBillMode = await billRepository.createBill(bill: dataSendBill.billModel);
    if (reponseCreateBillMode.id != null) {
      for (var element in dataSendBill.billModel.listDetail) {
        element.idBill = reponseCreateBillMode.id;
        await billRepository.createBillDetail(billDetailModel: element);
      }
    }
    emit(state.copyWith(status: PaymentStatus.success));
  }
}
