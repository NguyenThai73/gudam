import 'package:service_bill/service_bill.dart';

class BillRepository {
  final ServiceBill serviceBill = ServiceBill();

  Future<BillModel> createBill({required BillModel bill}) async {
    return await serviceBill.createBill(bill: bill);
  }

  Future<bool> createBillDetail({required BillDetailModel billDetailModel}) async {
    return await serviceBill.createBillDetail(billDetailModel: billDetailModel);
  }

  Future<List<BillModel>> getListBill({required int idUser, required int status}) async {
    return await serviceBill.getListBill(idUser: idUser, status: status);
  }

  Future<List<BillDetailModel>> getListBillDetail({required int idBill}) async {
    return await serviceBill.getListBillDetail(idBill: idBill);
  }

  updateBill({required BillModel bill}) async {
    return await serviceBill.updateBill(bill: bill);
  }

  updateHistoryBill({int? idBill, required int status, required String moTa}) async {
    return await serviceBill.updateHistoryBill(idBill: idBill, status: status, moTa: moTa);
  }

  Future<List<BillHistoryModel>> getListBillHistory({required int idBill}) async{
     return await serviceBill.getListBillHistory(idBill: idBill);
  }
}
