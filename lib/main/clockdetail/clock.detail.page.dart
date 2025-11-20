// ignore_for_file: prefer_const_constructors
import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/dialog.show.image.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_clock/service_clock.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/loading/loading.cubit.dart';
import '../../constants/format.dart';
import '../cart/cart.component.dart';
import '../cart/cart.cubit.dart';
import '../favorite/favorite.cubit.dart';
import 'clock.detail.cubit.dart';
import 'clock.detail.cubit.state.dart';

class ClockDetailPage extends StatefulWidget {
  final ClockModel clockModel;
  const ClockDetailPage({super.key, required this.clockModel});

  @override
  State<ClockDetailPage> createState() => _ClockDetailPageState();
}

class _ClockDetailPageState extends State<ClockDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<ClockDetailCubit, ClockDetailCubitState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      // state.clockModel.listImage().isNotEmpty
                      //     ? CarouselSlider(
                      //         options: CarouselOptions(
                      //           autoPlayInterval: Duration(milliseconds: 5000),
                      //           autoPlay: true,
                      //           aspectRatio: 2 / 3,
                      //           enlargeCenterPage: true,
                      //           viewportFraction: 1,
                      //         ),
                      //         items: state.clockModel.listImage().map((url) {
                      //           return SizedBox(
                      //             width: MediaQuery.of(context).size.width,
                      //             height: MediaQuery.of(context).size.height * 0.61,
                      //             child: ButtonNotClickMulti(
                      //               onTap: () {
                      //                 context.showDialogImage("$baseUrlImage$url");
                      //               },
                      //               child: CachedNetworkImage(
                      //                 imageUrl: "$baseUrlImage$url",
                      //                 fit: BoxFit.cover,
                      //                 errorWidget: (context, url, error) => Image.asset(
                      //                   "assets/clock.jpeg",
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         }).toList(),
                      //       )
                      //     :
                           SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.61,
                              child: ButtonNotClickMulti(
                                onTap: () {
                                  // context.showDialogImage("$baseUrlImage$url");
                                },
                                child: Image.asset(
                                  "assets/clock.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                    ],
                  );
                },
              ),
            ),
            Positioned.fill(
              child: BlocConsumer<ClockDetailCubit, ClockDetailCubitState>(
                listener: (context, state) {
                  if (state.status == ClockDetailStatus.loading) {
                    context.read<LoadingCubit>().makeLoading();
                  } else {
                    context.read<LoadingCubit>().makeNoneLoading();
                  }
                },
                builder: (context, state) {
                  return DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      maxChildSize: 0.85,
                      minChildSize: 0.4,
                      builder: (context, controller) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Center(child: Container(width: 65, height: 3, color: Color(0xFFC2C2C2))),
                                SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.clockModel.name ?? "",
                                          style: TextStyle(color: Color(0xFF34493A), fontSize: 20, fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "${formatNumber(int.tryParse(state.clockModel.price.toString()) ?? 0)} VNĐ",
                                          style: const TextStyle(fontSize: 18, color: Color(0xFFDF0000)),
                                        )
                                      ],
                                    )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: colorMain,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              padding: EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        context.read<ClockDetailCubit>().removeNumberBuy();
                                                      },
                                                      child: Icon(Icons.remove, color: Colors.white, size: 20)),
                                                  SizedBox(width: 10),
                                                  Text("${state.numberBuy}",
                                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                                                  SizedBox(width: 10),
                                                  InkWell(
                                                      onTap: () {
                                                        context.read<ClockDetailCubit>().addNumberBuy();
                                                      },
                                                      child: Icon(Icons.add, color: Colors.white, size: 20))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Còn ${state.clockModel.quantity ?? 0} sản phẩm",
                                          style: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                                        )
                                      ],
                                    )),
                                    SizedBox(width: 15),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 15),
                                  Text("Mô tả", style: TextStyle(fontSize: 14, color: Color(0xFF000000))),
                                  SizedBox(width: 15)
                                ]),
                                SizedBox(height: 10),
                                Row(children: [
                                  SizedBox(width: 15),
                                  Expanded(
                                      child: Text(state.clockModel.descriptionDecor ?? "", style: TextStyle(fontSize: 14, color: Color(0xFF9D9999)))),
                                  SizedBox(width: 15)
                                ]),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<ClockDetailCubit, ClockDetailCubitState>(
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7, 
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: ButtonNotClickMulti(
                                onTap: () {
                                  context
                                      .read<CartCubit>()
                                      .addCart(clockModel: widget.clockModel, number: (state.numberBuy > 0) ? state.numberBuy : 1);
                                  context.read<ClockDetailCubit>().resetNumberBuy();
                                },
                                child: Column(
                                  children: [
                                    SizedBox(width: 30, height: 30, child: Image.asset("assets/add_cart.png")),
                                    Text(
                                      "Thêm vào\ngiỏ hàng",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ButtonNotClickMulti(
                                onTap: () {
                                  context.push(MainRouterPath.routerBuyNow,
                                      extra: CartItem(
                                          idClock: widget.clockModel.id,
                                          clock: widget.clockModel,
                                          number: (state.numberBuy == 0) ? 1 : state.numberBuy));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: colorMain,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                        offset: const Offset(0, 7), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/Icon_buy.png",
                                        width: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Mua ngay",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // SizedBox(height: 15),
                ],
              ),
            ),
            Positioned.fill(
                child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
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
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: BlocBuilder<FavoriteCubit, FavoriteCubitState>(
                              builder: (context, state) {
                                return ButtonNotClickMulti(
                                  onTap: () {
                                    context.read<FavoriteCubit>().handleFavorite(clock: widget.clockModel);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.favorite,
                                      size: 20,
                                      color: state.listFavorite.contains(widget.clockModel.id ?? 0) ? const Color(0xFFDF0505) : Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          CartComponent(page: "clockDetails"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
    required this.isOnDesktopAndWeb,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        color: colorScheme.onSurface,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 32.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
