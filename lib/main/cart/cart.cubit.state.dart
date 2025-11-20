// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:service_clock/service_clock.dart';

class CartCubitState extends Equatable {
  final CartStatus status;
  List<CartItem> listCart;
  List<bool> listSelected;
  final int total;
  CartCubitState({
    required this.status,
    required this.listCart,
    required this.listSelected,
    required this.total,
  });

  CartCubitState copyWith({
    CartStatus? status,
    List<CartItem>? listCart,
    List<bool>? listSelected,
    int? total,
  }) {
    return CartCubitState(
      status: status ?? this.status,
      listCart: listCart ?? this.listCart,
      listSelected: listSelected ?? this.listSelected,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [status, listCart, listCart.length, listSelected, listSelected.length, total];
}

enum CartStatus { initial, loading, success, error }
