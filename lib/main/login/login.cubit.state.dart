// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_user/service_user.dart';

class LoginCubitState extends Equatable {
  final LoginStatus status;
  final UserModel userModel;
  const LoginCubitState({
    required this.status,
    required this.userModel,
  });

  LoginCubitState copyWith({
    LoginStatus? status,
    UserModel? userModel,
  }) {
    return LoginCubitState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [status, userModel];
}

enum LoginStatus { initial, loading, success, error }
