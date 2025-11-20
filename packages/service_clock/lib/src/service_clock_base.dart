import 'package:service_base/service_base.dart';
import 'package:service_clock/service_clock.dart';

class ServiceClock extends BaseService {
  Future<List<ClockTypeModel>> getListClockType() async {
    List<ClockTypeModel> listData = [];
    try {
      await get(
        route: "clock-type/get/page?page=0&size=100000&sort=id,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(ClockTypeModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<ClockModel>> getListClock({
    String? name,
    int? idClockType,
  }) async {
    List<ClockModel> listData = [];
    String filtterName = "";
    String filtterclockId = "";
    if (name != null) {
      filtterName = "&filter=name~'*$name*'";
    }
    if (idClockType != null) {
      filtterclockId = "&filter=idClockType: $idClockType";
    }
    try {
      await get(
        route: "clock/get/page?page=0&size=100000$filtterName$filtterclockId&filter=status:1&sort=id,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(ClockModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<ClockModel>> getListBestSelling() async {
    List<ClockModel> listData = [];
    try {
      await get(
        route: "clock/get/page?page=0&size=20&sort=sold,desc",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(ClockModel.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<List<CartItem>> getListCart({required int idUser}) async {
    List<CartItem> listData = [];
    try {
      await get(
        route: "cart/get/page?filter=idUser:$idUser",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listData.add(CartItem.fromMap(element));
            }
          }
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return listData;
  }

  Future<CartItem> addCart({required int idClock, required int number, required int idUser}) async {
    Map<String, dynamic> requestBodyLogin = {"idClock": idClock, "idUser": idUser, "number": number};
    CartItem cartItem = CartItem();
    try {
      await post(
        api: "cart/post",
        body: requestBodyLogin,
        timeout: 50,
        onConvert: (data) {
          cartItem = CartItem.fromMap(data ?? {});
        },
      );
    } catch (e) {
      print("Loi: $e");
    }
    return cartItem;
  }

  update({required CartItem cart}) async {
    try {
      await put(
        api: "cart/put/${cart.id}",
        body: cart.toMap(),
        timeout: 50,
        onConvert: (data) {},
      );
    } catch (e) {
      print("Loi: $e");
    }
  }

  void dateteCart({required int idCart}) async {
    try {
      await delete(
        api: "cart/del/$idCart",
        timeout: 50,
      );
    } catch (e) {}
  }
}
