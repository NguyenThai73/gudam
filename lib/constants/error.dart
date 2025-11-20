// ignore_for_file: must_be_immutable
import 'package:app_dong_ho/constants/style.dart';
import 'package:flutter/material.dart';

import 'my.dialog.dart';

class ErrorDialogApp extends StatefulWidget {
  Widget? child;
  final String? message;
  ErrorDialogApp({super.key, this.child, this.message});

  @override
  State<ErrorDialogApp> createState() => _ErrorDialogAppState();
}

class _ErrorDialogAppState extends State<ErrorDialogApp> {
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      child: widget.child ??
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.message ?? "Có lỗi xảy ra.",
                style:  TextStyle(color: colorMain, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorMain,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    )),
              ),
            ],
          ),
    );
  }
}
