import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<bool> {
  int totalLoading = 0;
  Timer? _delay;
  LoadingCubit() : super(false);

  makeLoading() {
    print('loading $totalLoading');
    totalLoading++;
    if (_delay == null) {
      _delay = Timer(const Duration(seconds: 5), () {
        hideLoading();
      });
    } else {
      _delay?.cancel();
      _delay = null;
      _delay = Timer(const Duration(seconds: 5), () {
        hideLoading();
      });
    }
    emit(true);
  }

  @override
  close() async {
    _delay?.cancel();
    _delay = null;
    super.close();
  }

  makeNoneLoading() {
    if (totalLoading > 0) {
      totalLoading--;
      if (totalLoading == 0) {
        hideLoading();
      }
    }
    print('loadingHIde $totalLoading');

  }

  void hideLoading() {
    _delay?.cancel();
    _delay = null;
    totalLoading = 0;
    emit(false);
  }
}
