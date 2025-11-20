// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../button.not.click.multi.dart';
import '../../my.dialog.dart';
import 'error.cubit.dart';

class ErrorDialog extends StatefulWidget {
  Widget? child;
  ErrorDialog({super.key, this.child});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  void deactivate() {
    super.deactivate();
    context.read<ErrorCubit>().closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      onClickOutSide: () {
        // context.read<ErrorCubit>().closeDialog();
      },
      child: widget.child ??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Error!!!",
                  style: TextStyle(color: Colors.black, fontSize: 25)),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ButtonNotClickMulti(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          // gradient: MyGradient.gradientMain,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('OK',
                          style: TextStyle(color: Colors.white)),
                    )),
              ),
            ],
          ),
    );
  }
}
