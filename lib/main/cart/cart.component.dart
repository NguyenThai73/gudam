
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/button.not.click.multi.dart';
import 'cart.cubit.dart';
import 'cart.cubit.state.dart';

class CartComponent extends StatelessWidget {
  final String page;
  const CartComponent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return ButtonNotClickMulti(
      onTap: (){
        context.push(MainRouterPath.routerCartPage);
      },
      child: BlocBuilder<CartCubit, CartCubitState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return page == "home"
              ? SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset("assets/icon_cart.png"),
                      ),
                      Positioned.fill(
                        child: state.listCart.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.red),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          "${state.listCart.length}",
                                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                )
              : page == "clockDetails"
                  ? Container(
                      margin: const EdgeInsets.only(top: 8, left: 8),
                      width: 30,
                      height: 30,
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image.asset(
                            "assets/cart.png",
                            fit: BoxFit.cover,
                          )),
                          Positioned.fill(
                            child: state.listCart.isNotEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.red),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              "${state.listCart.length}",
                                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    )
                  : Container();
        },
      ),
    );
  }
}
