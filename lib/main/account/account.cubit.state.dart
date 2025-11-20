// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_user/service_user.dart';

class AccountCubitState extends Equatable {
  final AccountStatus status;
  const AccountCubitState({
    required this.status,
  });

  AccountCubitState copyWith({
    AccountStatus? status,
    UserModel? userModel,
  }) {
    return AccountCubitState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

enum AccountStatus { initial, loading, success, error }
