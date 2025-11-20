import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';

import 'cart.cubit.state.dart';

class CartCubit extends Cubit<CartCubitState> {
  final ClockRepository clockRepository;
  final AuthenticationRepository authenticationRepository;

  CartCubit({required this.clockRepository, required this.authenticationRepository})
      : super(CartCubitState(status: CartStatus.initial, listCart: [], listSelected: [], total: 0));
  getData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(status: CartStatus.loading));
    List<CartItem> listCartGet = await clockRepository.getListCart(idUser: authenticationRepository.currentUser?.id ?? 0);
    emit(state.copyWith(status: CartStatus.success, listCart: listCartGet));
  }

  cleanData() async {
    emit(state.copyWith(status: CartStatus.initial, listCart: [], listSelected: [], total: 0));
  }

  void addCart({required ClockModel clockModel, required int number}) async {
    emit(state.copyWith(status: CartStatus.loading));
    var check = false;
    int indext = 0;
    for (int i = 0; i < state.listCart.length; i++) {
      if (state.listCart[i].idClock == clockModel.id) {
        check = true;
        indext = i;
      }
    }
    if (check) {
      if (state.listCart[indext].number != null) {
        state.listCart[indext].number = state.listCart[indext].number! + number;
        await clockRepository.update(cart: state.listCart[indext]);
        emit(state.copyWith(listCart: state.listCart, status: CartStatus.success));
      }
    } else {
      var cartNew = await clockRepository.addCart(idClock: clockModel.id ?? 0, number: number, idUser: authenticationRepository.currentUser?.id ?? 0);
      if (cartNew.id != null) {
        cartNew.clock = clockModel;
        state.listCart.add(CartItem(id: clockModel.id, idClock: clockModel.id, clock: clockModel, number: number));
        emit(state.copyWith(listCart: state.listCart, status: CartStatus.success));
      } else {
        emit(state.copyWith(listCart: state.listCart, status: CartStatus.error));
      }
    }
  }

  setTotal() {
    int totalNew = 0;
    for (int i = 0; i < state.listCart.length; i++) {
      if (state.listSelected[i] == true) {
        int value = state.listCart[i].totalPoint();
        totalNew = totalNew + value;
      }
    }
    emit(state.copyWith(total: totalNew));
  }

  resetValueSeclect() async {
    emit(state.copyWith(status: CartStatus.initial));
    List<bool> listSelect = [];
    for (int i = 0; i < state.listCart.length; i++) {
      listSelect.add(true);
    }
    emit(state.copyWith(listSelected: listSelect, status: CartStatus.success));
    await Future.delayed(const Duration(milliseconds: 500)).then((value) => setTotal());
  }

  handleSelected(int index) {
    emit(state.copyWith(status: CartStatus.initial));
    state.listSelected[index] = !state.listSelected[index];
    setTotal();
    emit(state.copyWith(listSelected: state.listSelected, status: CartStatus.success));
  }

  void removeNumberCart(int index) {
    emit(state.copyWith(status: CartStatus.initial));
    if (state.listCart[index].number != null && state.listCart[index].number! > 0) {
      state.listCart[index].number = state.listCart[index].number! - 1;
    }
    setTotal();
    emit(state.copyWith(listCart: state.listCart, status: CartStatus.success));
  }

  void addNumberCart(int index) {
    emit(state.copyWith(status: CartStatus.initial));
    if (state.listCart[index].number != null) {
      state.listCart[index].number = state.listCart[index].number! + 1;
    }
    setTotal();
    emit(state.copyWith(listCart: state.listCart, status: CartStatus.success));
  }

  void deleteCart({required List<CartItem> listCartRemove}) async{
    emit(state.copyWith(status: CartStatus.initial));
    for (var element in listCartRemove) {
      state.listCart.remove(element);
      await clockRepository.dateteCart(idCart: element.id??0);
    }
    emit(state.copyWith(listCart: state.listCart, status: CartStatus.success));
  }
}
