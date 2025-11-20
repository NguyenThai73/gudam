import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error.cubit.state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(const ErrorState());

  void showDialog({Widget? widgetShow}) {
    emit(state.copyWith(
        status: ErrorStatus.showing, widget: widgetShow));
  }

  void closeDialog() {
    emit(state.copyWith(status: ErrorStatus.close, widget: null));
  }
}
