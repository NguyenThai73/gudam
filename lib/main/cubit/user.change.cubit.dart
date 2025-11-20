import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';

class UserChangeCubit extends Cubit<UserModel?> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<UserModel?> _listenUser;
  UserChangeCubit(this._authenticationRepository) : super(null) {
    _listenUser = _authenticationRepository.user.listen((event) {
      emit(event);
    });
    // getUser();
  }
  // getUser() async {
  //   var uid = await MySharedPreferences.getUID();
  //   var user = await _authenticationRepository.getUserMoodel(uid: uid);
  //   print("objectobjectobjectobjectobject: $user");
  //   emit(user);
  // }

  @override
  Future<void> close() {
    _listenUser.cancel();
    return super.close();
  }
}
