import 'package:service_clock/service_clock.dart';

class ClockRepository {
  final ServiceClock serviceClock = ServiceClock();

  Future<List<ClockTypeModel>> getListClockType() async {
    return await serviceClock.getListClockType();
  }

  Future<List<ClockModel>> getListClock({
    String? name,
    int? idClockType,
  }) async {
    return await serviceClock.getListClock(name: name, idClockType: idClockType);
  }

  Future<List<ClockModel>> getListBestSelling() async {
    return await serviceClock.getListBestSelling();
  }

  Future<List<CartItem>> getListCart({required int idUser}) async {
    return await serviceClock.getListCart(idUser: idUser);
  }

  Future<CartItem> addCart({required int idClock, required int number, required int idUser}) async {
    return await serviceClock.addCart(idClock: idClock, number: number, idUser: idUser);
  }

  update({required CartItem cart}) async {
    await serviceClock.update(cart: cart);
  }

  dateteCart({required int idCart}) {
    serviceClock.dateteCart(idCart: idCart);
  }
}
