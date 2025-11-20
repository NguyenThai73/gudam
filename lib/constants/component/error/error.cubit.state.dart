// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ErrorState extends Equatable {
  final ErrorStatus status;
  final Widget? widget;
  const ErrorState({
    this.status = ErrorStatus.close,
    this.widget,
  });

  ErrorState copyWith({
    ErrorStatus? status,
    Widget? widget,
  }) {
    return ErrorState(
      status: status ?? this.status,
      widget: widget ?? this.widget,
    );
  }

  @override
  List<Object> get props => [status];
}

enum ErrorStatus { showing, close}
