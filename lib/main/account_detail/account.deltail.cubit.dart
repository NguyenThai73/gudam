// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/authentication.repository.dart';
import 'account.deltail.cubit.state.dart';

class AccountDetailCubit extends Cubit<AccountDetailCubitState> {
  final AuthenticationRepository authenticationRepository;

  AccountDetailCubit({required this.authenticationRepository})
      : super(AccountDetailCubitState(
          status: AccountDetailStatus.initial,
          avatar: authenticationRepository.currentUser?.avatar ?? "",
          fullName: authenticationRepository.currentUser?.fullName ?? "",
          sdt: authenticationRepository.currentUser?.sdt ?? "",
          address: authenticationRepository.currentUser?.address ?? "",
          gender: authenticationRepository.currentUser?.gioiTinh ?? true,
        )) {
    setData();
  }
  List<String> listGender = ["Nam", "Nữ"];
  TextEditingController nameController = TextEditingController();
  TextEditingController sdtcontroller = TextEditingController();
  TextEditingController addressController = TextEditingController();

  setData() {
    nameController.text = state.fullName;
    sdtcontroller.text = state.sdt;
    addressController.text = state.address;
  }

  changeAvatar(String avatar) {
    emit(state.copyWith(status: AccountDetailStatus.loading));
    emit(state.copyWith(status: AccountDetailStatus.initial, avatar: avatar));
  }

  changeFulName() {
    emit(state.copyWith(fullName: nameController.text));
  }

  changeGioiTinh(String gender) {
    emit(state.copyWith(gender: gender == "Nữ"));
  }

  changeSdt() {
    emit(state.copyWith(sdt: sdtcontroller.text));
  }

  changeAddress() {
    emit(state.copyWith(address: addressController.text));
  }

  updateProfile() async {
    if (state.fullName != "") {
      var userNew = authenticationRepository.currentUser?.copyWith(
        fullName: state.fullName,
        sdt: state.sdt,
        address: state.address,
        avatar: state.avatar,
        gioiTinh: state.gender,
      );
      if (userNew != null) {
        var check = await authenticationRepository.updateUserDatabase(userNew);
        if (check) {
          authenticationRepository.userChange(userNew);
          return userNew;
        }
      }
    }
  }
}
