import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_clock/service_clock.dart';
import 'home.cubit.state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  final ClockRepository clockRepository;
  HomeCubit({required this.clockRepository}) : super(const HomeCubitState(status: Status.initial, listSuggest: [], listBestSelling: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    List<ClockModel> listSuggest = await clockRepository.getListClock();
    List<ClockModel> listBestSelling = await clockRepository.getListBestSelling();
    emit(state.copyWith(status: Status.success, listSuggest: listSuggest, listBestSelling: listBestSelling));
  }
}
