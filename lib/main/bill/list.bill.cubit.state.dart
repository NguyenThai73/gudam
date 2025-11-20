import 'package:equatable/equatable.dart';
import 'package:service_bill/service_bill.dart';

class ListBillCubitState extends Equatable {
  ListBillStatus status;
  int tabNumber;
  List<BillModel> listBill;

  ListBillCubitState({
    required this.status,
    required this.listBill,
    required this.tabNumber,
  });

  ListBillCubitState copyWith({
    ListBillStatus? status,
    List<BillModel>? listBill,
    int? tabNumber,
  }) {
    return ListBillCubitState(
      status: status ?? this.status,
      listBill: listBill ?? this.listBill,
      tabNumber: tabNumber ?? this.tabNumber,
    );
  }

  @override
  List<Object?> get props => [status, listBill, listBill.length, tabNumber];
}

enum ListBillStatus { initial, loading, success, error }
