import 'package:app_dong_ho/constants/clock.item.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main/cart/cart.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/button.not.click.multi.dart';
import '../../main.router.constant.dart';
import 'favorite.cubit.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 15),
               Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Yêu thích",
                      style: TextStyle(fontSize: 24, color: colorMain, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ButtonNotClickMulti(
                        onTap: () {
                          context.push(MainRouterPath.routerSearch);
                        },
                        child: Image.asset("assets/icon_search.png")),
                  ),
                  const SizedBox(width: 12),
                  const CartComponent(page: "home"),
                ],
              )),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 5,
            color: const Color(0xFFF4F4F4),
          ),
          const SizedBox(height: 10),
          Expanded(child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
            builder: (context, state) {
              return Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: state.listFavoriteModel.map((e) {
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
                  ));
            },
          ))
        ],
      ),
    );
  }
}
