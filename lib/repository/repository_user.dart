import 'package:rxdart/rxdart.dart';
import 'package:service_user/service_user.dart';

class UserRepository {
  final ServiceUser serviceUser = ServiceUser();
  UserModel? _user;
  final _userChange = BehaviorSubject<UserModel?>();

  UserModel? getUser() {
    if (_user != null) return _user;
    return null;
  }

  signUp(Map<String, dynamic> map) {}

  Stream<UserModel?> get user {
    return _userChange.stream;
  }

  void updateUser(user) {
    _user = user;
    _userChange.add(user);
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return await serviceUser.register(email: email, password: password, name: name);
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    return await serviceUser.login(email: email, password: password);
  }
}
