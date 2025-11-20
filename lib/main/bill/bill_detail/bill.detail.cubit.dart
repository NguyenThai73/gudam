import 'package:app_dong_ho/repository/repository_bill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bill/service_bill.dart';

import 'bill.detail.cubit.state.dart';

class BillDetailCubit extends Cubit<BillDetailCubitState> {
  final BillRepository billRepository;
  final BillModel billModel;

  BillDetailCubit({required this.billRepository, required this.billModel})
      : super(BillDetailCubitState(status: BillDEtailStatus.initial, billModel: billModel)) {
    getData();
  }
  getData() async {
    print(billModel.toMap());
    // var uid = await MySharedPreferences.getUID();
    // var user = await _authenticationRepository.getUserMoodel(uid: uid);
    // print("objectobjectobjectobjectobject: $user");
    // emit(user);
  }
}
