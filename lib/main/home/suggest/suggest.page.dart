import 'package:app_dong_ho/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_clock/service_clock.dart';

import '../../../constants/button.not.click.multi.dart';
import '../../../constants/clock.item.dart';

class SuggestPage extends StatelessWidget {
  final List<ClockModel> listClock;
  final String pageName;
  const SuggestPage({super.key, required this.listClock, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 15),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
              child: ButtonNotClickMulti(
                onTap: () {
                  context.pop();
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          pageName,
          style:  TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: colorMain),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: listClock.map((e) {
                double width = 0;
                var widthScreen = MediaQuery.of(context).size.width / 2 - 20;
                if (widthScreen > 206) {
                  width = 206;
                } else {
                  width = widthScreen;
                }
                return SizedBox(
                  height: 206,
                  child: ClockItem(
                    width: width,
                    clock: e,
                  ),
                );
              }).toList(),
            ),
          )
          ),
    );
  }
}
