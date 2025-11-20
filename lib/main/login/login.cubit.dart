// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';
import 'login.cubit.state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final AuthenticationRepository authenticationRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginCubit({required this.authenticationRepository}) : super(LoginCubitState(status: LoginStatus.initial, userModel: UserModel()));

  Future<UserModel?> login() async {
    emit(state.copyWith(status: LoginStatus.loading));
    var response = await authenticationRepository.login(email: emailController.text, password: passwordController.text);
    if (response != null) {
      emit(state.copyWith(status: LoginStatus.success));
    } else {
      emit(state.copyWith(status: LoginStatus.error));
    }
    return response;
  }
}
