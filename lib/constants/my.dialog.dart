import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final Function? onClickOutSide;
  final Widget child;
  const MyDialog({
    super.key,
    required this.child,
    this.onClickOutSide,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        textStyle: const TextStyle(fontFamily: 'NotoSansJP'),
        color: Colors.transparent,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (onClickOutSide != null) {
                onClickOutSide!();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 300 / 375,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: child),
              ],
            )),
      ),
    );
  }
}
