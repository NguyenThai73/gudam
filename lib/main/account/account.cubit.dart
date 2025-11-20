// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';
import 'account.cubit.state.dart';

class AccountCubit extends Cubit<AccountCubitState> {
  final AuthenticationRepository authenticationRepository;

  AccountCubit({required this.authenticationRepository}) : super(const AccountCubitState(status: AccountStatus.initial));

  Future<UserModel?> login({required String email, required String pass}) async {
    return await authenticationRepository.login(email: email, password: pass);
  }

  Future<bool> changePass({required String password}) async {
    return await authenticationRepository.changePassword(password: password, idUser: authenticationRepository.currentUser?.id ?? 0);
  }
}
