import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

extension DialogShowImage on BuildContext {
  Future showDialogImage(String link) async {
    await showDialog(
      context: this,
      builder: (context) {
        var listenValue = ValueNotifier<double>(1);
        var positionListen = ValueNotifier<Offset>(const Offset(0, 0));
        double? previousScale;
        Offset? previousOffset;
        Offset? changeOffset;
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
                onScaleStart: (ScaleStartDetails details) {
                  previousScale = listenValue.value;
                  changeOffset = details.focalPoint;
                },
                onScaleUpdate: (ScaleUpdateDetails details) {
                  listenValue.value = (previousScale ?? 0) * details.scale;

                  if (details.pointerCount == 1) {
                    positionListen.value = (previousOffset ??
                            const Offset(0, 0)) +
                        Offset(details.focalPoint.dx - (changeOffset?.dx ?? 0),
                            details.focalPoint.dy - (changeOffset?.dy ?? 0));
                  }
                },
                onScaleEnd: (ScaleEndDetails details) {
                  previousScale = null;
                  changeOffset = null;
                  // if (details.pointerCount == 1) {
                  previousOffset = positionListen.value;
                  // }
                },
                child: ValueListenableBuilder<double>(
                    valueListenable: listenValue,
                    builder: (context, value, child) {
                      return ValueListenableBuilder<Offset>(
                          valueListenable: positionListen,
                          builder: (context, offset, child) {
                            return Transform.translate(
                              offset: offset,
                              child: Transform(
                                transform: Matrix4.diagonal3(
                                    vector.Vector3(value, value, value)),
                                alignment: FractionalOffset.center,
                                child: Image.network(
                                  link,
                                ),
                              ),
                            );
                          });
                    })),
            Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(8),
                      child: Text("OK",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white))),
                ))
          ],
        );
      },
    );
  }
}
