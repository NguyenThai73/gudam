import 'package:flutter/material.dart';

import '../../button.not.click.multi.dart';
import 'error.model.dart';

class ErrorWidgetApp extends StatelessWidget {
  final ErrorModel errorModel;
  const ErrorWidgetApp({super.key, required this.errorModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          errorModel.title ?? "Error!!!",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorModel.handleOk != null)
              ButtonNotClickMulti(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // gradient: MyGradient.gradientMain,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text("OK",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  )),
            ButtonNotClickMulti(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(255, 18, 93, 255),
                            Color.fromARGB(255, 98, 185, 255)
                          ]),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ))
          ],
        )
      ],
    );
  }
}
