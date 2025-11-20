// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_user/service_user.dart';

class RegisterCubitState extends Equatable {
  final Status status;
  final UserModel userModel;
  const RegisterCubitState({
    required this.status,
    required this.userModel,
  });

  RegisterCubitState copyWith({
    Status? status,
    UserModel? userModel,
  }) {
    return RegisterCubitState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [status, userModel];
}

enum Status { initial, loading, success, error }
