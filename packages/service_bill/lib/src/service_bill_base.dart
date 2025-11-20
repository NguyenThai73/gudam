// TODO: Put public facing types in this file.

import 'package:service_base/service_base.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_bill/src/model/bill.model.dart';

/// Checks if you are awesome. Spoiler: you are.
class ServiceBill extends BaseService {
  bool get isAwesome => true;

  Future<BillModel> createBill({required BillModel bill}) async {
    BillModel billModel = BillModel(listDetail: []);
    try {
      await post(
        api: "bill/post",
        body: bill.toMap(),
        timeout: 50,
        onConvert: (data) {
          billModel = BillModel.fromMap(data ?? {});
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return billModel;
  }

  Future<bool> createBillDetail({required BillDetailModel billDetailModel}) async {
    try {
      await post(
        api: "bill-detail/post",
        body: billDetailModel.toMap(),
        timeout: 50,
        onConvert: (data) {},
      );
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  Future<List<BillModel>> getListBill({required int idUser, required int status}) async {
    List<BillModel> listData = [];
    try {
      await get(
        route: "bill/get/page?filter=idUser:$idUser and status:$status",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(BillModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<BillDetailModel>> getListBillDetail({required int idBill}) async {
    List<BillDetailModel> listData = [];
    try {
      await get(
        route: "bill-detail/get/page?filter=idBill:$idBill",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(BillDetailModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  updateBill({required BillModel bill}) async {
    try {
      await put(
        api: "bill/put/${bill.id}",
        body: bill.toMap(),
        timeout: 50,
        onConvert: (data) {},
      );
    } catch (e) {
      print("Loi: $e");
    }
  }

  updateHistoryBill({int? idBill, required int status, required String moTa}) async {
    try {
      var data = {"idBill": idBill, "descriptionBill": moTa, "status": status};
      await post(
        api: "history-bill/post",
        body: data,
        timeout: 50,
        onConvert: (data) {},
      );
    } catch (e) {
      print("Loi: $e");
    }
  }

  Future<List<BillHistoryModel>> getListBillHistory({required int idBill}) async {
    List<BillHistoryModel> listData = [];
    try {
      await get(
        route: "history-bill/get/page?filter=idBill:$idBill",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(BillHistoryModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }
}
