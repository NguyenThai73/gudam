// ignore_for_file: prefer_const_constructors
import 'package:app_dong_ho/constants/avar.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main/home/clock_type/clock.type.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cart/cart.component.dart';
import 'bestselling/best.selling.component.dart';
import 'home.cubit.dart';
import 'home.cubit.state.dart';
import 'suggest/suggest.component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              const Avar(),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ButtonNotClickMulti(onTap: () {context.push(MainRouterPath.routerSearch);}, child: Image.asset("assets/icon_search.png")),
                  ),
                  const SizedBox(width: 12),
                  CartComponent(page:"home"),
                ],
              )),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeCubitState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                         Text(
                          "Tìm kiếm cây của bạn!",
                          style: TextStyle(fontSize: 20, color: colorMain, fontWeight: FontWeight.w700, height: 1),
                        ),
                        const SizedBox(height: 20),
                        ClockTypeComponent(),
                        const SizedBox(height: 5),
                        SuggestComponent(
                          listClock: state.listSuggest,
                        ),
                        const SizedBox(height: 30),
                        BestSellingComponent(
                          listClock: state.listBestSelling,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
