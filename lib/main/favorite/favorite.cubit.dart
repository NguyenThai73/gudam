import 'package:app_dong_ho/repository/repository_clock.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_clock/service_clock.dart';

import '../../repository/authentication.repository.dart';

class FavoriteCubit extends Cubit<FavoriteCubitState> {
  final AuthenticationRepository authenticationRepository;
  final ClockRepository clockRepository;

  FavoriteCubit(this.authenticationRepository, this.clockRepository)
      : super(FavoriteCubitState(status: FavoriteStatus.initial, listFavorite: [], listFavoriteModel: [])) ;
  getData() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    List<ClockModel> listF = await authenticationRepository.getFavorite();
    List<int> listId = List.generate(listF.length, (index) => listF[index].id ?? 0);
    emit(state.copyWith(status: FavoriteStatus.success, listFavorite: listId, listFavoriteModel: listF));
  }

  cleanData() {
    emit(state.copyWith(status: FavoriteStatus.initial, listFavorite: [], listFavoriteModel: []));
  }

  void handleFavorite({required ClockModel clock}) {
    if (clock.id != null) {
      emit(state.copyWith(status: FavoriteStatus.loading));
      if (state.listFavorite.contains(clock.id)) {
        var index = 0;
        for (var i = 0; i < state.listFavorite.length; i++) {
          if (state.listFavorite[i] == clock.id!) {
            index = i;
          }
        }
        state.listFavorite.removeAt(index);
        state.listFavoriteModel.removeAt(index);
        removeFavorite(clock);
      } else {
        state.listFavorite.add(clock.id ?? 0);
        state.listFavoriteModel.add(clock);
        addFavorite(clock);
      }
      emit(state.copyWith(status: FavoriteStatus.success, listFavorite: state.listFavorite, listFavoriteModel: state.listFavoriteModel));
    }
  }

  addFavorite(ClockModel clock) {
    authenticationRepository.addFavorite(idClock: clock.id ?? 0);
  }

  removeFavorite(ClockModel clock) {
    authenticationRepository.deleteFavorite(idClock: clock.id ?? 0);
  }
}

class FavoriteCubitState extends Equatable {
  final FavoriteStatus status;
  List<int> listFavorite;
  List<ClockModel> listFavoriteModel;

  FavoriteCubitState({
    required this.status,
    required this.listFavorite,
    required this.listFavoriteModel,
  });

  FavoriteCubitState copyWith({
    FavoriteStatus? status,
    List<int>? listFavorite,
    List<ClockModel>? listFavoriteModel,
  }) {
    return FavoriteCubitState(
      status: status ?? this.status,
      listFavorite: listFavorite ?? this.listFavorite,
      listFavoriteModel: listFavoriteModel ?? this.listFavoriteModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listFavorite,
        listFavorite.length,
        listFavoriteModel,
        listFavoriteModel.length,
      ];
}

enum FavoriteStatus { initial, loading, success, error }
