import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error.cubit.dart';

class ErrorWrapper extends StatelessWidget {
  final Widget child;

  const ErrorWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ErrorCubit(), child: child);
  }
}
