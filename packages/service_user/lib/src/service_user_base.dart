import 'package:service_base/service_base.dart';

import 'model/user.model.dart';

class ServiceUser extends BaseService {
  Future<UserModel?> login({required String email, required String password}) async {
    Map<String, String> requestBodyLogin = {"username": email, "password": password};
    UserModel? userLogin;
    try {
      await post(
        api: "nguoi-dung/login",
        body: requestBodyLogin,
        timeout: 50,
        onConvert: (data) {
          userLogin = UserModel.fromMap(data?['result']);
        },
      );
      return userLogin;
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

  Future<UserModel?> register({required String email, required String password, required String name}) async {
    var data = {"email": email, "password": password, "role": 1, "fullName": name, "status": 1};
    UserModel? userLogin;
    try {
      await post(
        api: "nguoi-dung/create",
        body: data,
        timeout: 50,
        onConvert: (data) {
          userLogin = UserModel.fromMap(data?['result']);
        },
      );
      return userLogin;
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }
  // Favorite<Map<String, dynamic>> getFavorite()async{}

  Future<bool> addFavorite({required int userId, required int idClock}) async {
    Map<String, dynamic> requestBodyLogin = {"idClock": idClock, "idUser": userId};
    try {
      await post(
        api: "favorite/post",
        body: requestBodyLogin,
        timeout: 50,
        onConvert: (data) {},
      );
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  Future<bool> deleteFavorite({required int idClock, required int userId}) async {
    try {
      List<int> listFavorite = [];
      await get(
        route: "favorite/get/page?filter=idClock:$idClock and idUser:$userId",
        timeout: 50,
        onConvert: (data) {
          if (data?['content'] != null && data?['content'] is List) {
            for (var element in data!['content']) {
              listFavorite.add(int.tryParse(element['id'].toString()) ?? 0);
            }
          }
        },
      );
      for (var element in listFavorite) {
        await delete(
          api: "favorite/del/$element",
          timeout: 50,
        );
      }

      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  Future<List<dynamic>> getFavorite({required int userId}) async {
    List<dynamic> dataconver = [];
    await get(
      route: "favorite/get/page?filter=idUser:$userId",
      timeout: 50,
      onConvert: (data) {
        if (data?['content'] != null && data?['content'] is List) {
          dataconver = data!['content'];
        }
      },
    );
    return dataconver;
  }

  Future<bool> updateUserDatabase(UserModel userModel) async {
    try {
      await put(
        api: "nguoi-dung/put/${userModel.id}",
        body: userModel.toMap(),
        timeout: 50,
        onConvert: (data) {},
      );
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }

  Future<bool> changePassword({required String password, required int idUser}) async {
    try {
      await post(
        api: "nguoi-dung/change-pass/$idUser",
        body: {"username": "", "password": password},
        timeout: 50,
        onConvert: (data) {},
      );
      return true;
    } catch (e) {
      print("Loi: $e");
      return false;
    }
  }
}
