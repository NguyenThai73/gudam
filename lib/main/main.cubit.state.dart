// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class MainCubitState extends Equatable {
  final MainStatus status;
  final int pageNumber;
  const MainCubitState({
    required this.status,
    required this.pageNumber,
  });

  MainCubitState copyWith({
    MainStatus? status,
    int? pageNumber,
  }) {
    return MainCubitState(
      status: status ?? this.status,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pageNumber,
      ];
}

enum MainStatus { initial, loading, success, error }

enum MainPageTab {
  home,
  rank,
}
