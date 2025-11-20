// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';
import 'register.cubit.state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  final AuthenticationRepository authenticationRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();

  RegisterCubit({required this.authenticationRepository}) : super(RegisterCubitState(status: Status.initial, userModel: UserModel()));

  Future<UserModel?> login({required String email, required String pass}) async {
    return await authenticationRepository.login(email: email, password: pass);
  }
}
