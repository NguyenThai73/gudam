import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading.component.dart';
import 'loading.cubit.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;

  const LoadingWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingCubit(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Positioned.fill(
              child: child,
            ),
            Positioned.fill(
              child: BlocBuilder<LoadingCubit, bool>(
                builder: (context, isShowLoading) {
                  if (isShowLoading) {
                    return const LoadingComponent();
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
