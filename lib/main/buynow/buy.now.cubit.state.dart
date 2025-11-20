// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_clock/service_clock.dart';

class BuyNowCubitState extends Equatable {
  final BuyNowStatus status;
  List<CartItem> listCart;
  final int total;
  BuyNowCubitState({
    required this.status,
    required this.listCart,
    required this.total,
  });

  BuyNowCubitState copyWith({
    BuyNowStatus? status,
    List<CartItem>? listCart,
    int? total,
  }) {
    return BuyNowCubitState(
      status: status ?? this.status,
      listCart: listCart ?? this.listCart,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [status, listCart, listCart.length, total];
}

enum BuyNowStatus { initial, loading, success, error }
