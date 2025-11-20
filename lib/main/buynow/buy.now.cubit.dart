import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';

import '../../repository/repository_clock.dart';
import 'buy.now.cubit.state.dart';

class BuyNowCubit extends Cubit<BuyNowCubitState> {
  final CartItem cartItem;
  final ClockRepository clockRepository;
  final AuthenticationRepository authenticationRepository;

  BuyNowCubit({required this.clockRepository, required this.authenticationRepository, required this.cartItem})
      : super(BuyNowCubitState(status: BuyNowStatus.initial, listCart: [cartItem], total: 0)) {
    setData();
  }
  setData() {
    emit(state.copyWith(status: BuyNowStatus.loading));
    emit(state.copyWith(status: BuyNowStatus.success, total: cartItem.totalPoint()));

  }
  setTotal() {
    int totalNew = 0;
    for (int i = 0; i < state.listCart.length; i++) {
      int value = state.listCart[i].totalPoint();
      totalNew = totalNew + value;
    }
    emit(state.copyWith(total: totalNew));
  }

  void removeNumberCart(int index) {
    emit(state.copyWith(status: BuyNowStatus.initial));
    if (state.listCart[index].number != null && state.listCart[index].number! > 1) {
      state.listCart[index].number = state.listCart[index].number! - 1;
    }
    setTotal();
    emit(state.copyWith(listCart: state.listCart, status: BuyNowStatus.success));
  }

  void addNumberCart(int index) {
    emit(state.copyWith(status: BuyNowStatus.initial));
    if (state.listCart[index].number != null) {
      state.listCart[index].number = state.listCart[index].number! + 1;
    }
    setTotal();
    emit(state.copyWith(listCart: state.listCart, status: BuyNowStatus.success));
  }
}
