import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main.cubit.state.dart';

class MainCubit extends Cubit<MainCubitState> {
  final PageController pageController = PageController();

  MainCubit()
      : super(const MainCubitState(
          status: MainStatus.initial,
          pageNumber: 0,
        )) {
    emit(state.copyWith(pageNumber: 0));
  }

  void selectBottomBar({required int page}) async {
    if ((page - state.pageNumber).abs() == 1) {
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      pageController.jumpToPage(page);
    }
    emit(state.copyWith(pageNumber: page));
  }
}
