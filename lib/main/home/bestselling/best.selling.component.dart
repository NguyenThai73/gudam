import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_clock/service_clock.dart';

import '../../../constants/clock.item.dart';
import '../../../main.router.constant.dart';
import '../component/data.page.model.dart';

class BestSellingComponent extends StatelessWidget {
  final List<ClockModel> listClock;

  const BestSellingComponent({super.key, required this.listClock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Sản phẩm bán chạy",
                style: TextStyle(fontSize: 20, color: colorMain, fontWeight: FontWeight.w700),
              ),
              ButtonNotClickMulti(
                  onTap: () {
                    context.push(MainRouterPath.routerClockPage, extra: DataPageModel(pageName: 'Sản phẩm bán chạy', listData: listClock));
                  },
                  child: const Text(
                    "Xem tất cả >",
                    style: TextStyle(fontSize: 12, color: Color(0xFF999898)),
                  )),
            ],
          ),
          SizedBox(
            height: 206,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listClock.length,
              itemBuilder: (context, index) {
                var clock = listClock[index];
                return ClockItem(clock: clock);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
