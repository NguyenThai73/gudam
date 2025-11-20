// ignore_for_file: prefer_const_constructors
import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/format.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bill.detail.cubit.dart';
import 'bill.detail.cubit.state.dart';

class BillDetailPage extends StatelessWidget {
  const BillDetailPage({super.key});

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
        title: const Text(
          "Thông tin đơn hàng",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF325A3E)),
        ),
        centerTitle: true,
        actions: [
          ButtonNotClickMulti(
            onTap: () {
              context.push(MainRouterPath.routerBillHistory, extra: context.read<BillDetailCubit>().billModel);
            },
            child: Icon(
              Icons.history,
              size: 30,
              color: Color(0xFF325A3E),
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
      body: BlocBuilder<BillDetailCubit, BillDetailCubitState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  color: const Color(0xFFF4F4F4),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      for (int i = 0; i < state.billModel.listDetail.length; i++)
                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 13),
                          padding: const EdgeInsets.only(bottom: 13),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: (state.billModel.listDetail[i].clock?.listImage().first != null &&
                                          state.billModel.listDetail[i].clock?.listImage().first != "")
                                      ? CachedNetworkImage(
                                          imageUrl: "$baseUrlImage${state.billModel.listDetail[i].clock?.listImage().first}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) => Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: const DecorationImage(image: AssetImage("assets/clock.png"), fit: BoxFit.cover),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: const DecorationImage(image: AssetImage("assets/clock.png"), fit: BoxFit.cover),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: const DecorationImage(image: AssetImage("assets/clock.png"), fit: BoxFit.cover),
                                          ),
                                        )),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${state.billModel.listDetail[i].clock?.name}",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${formatNumber(int.tryParse(state.billModel.listDetail[i].clock!.price.toString()) ?? 0)} VNĐ",
                                          style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                                        ),
                                        Text("x${state.billModel.listDetail[i].number}", style: const TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Giá: ${formatNumber(int.tryParse(state.billModel.listDetail[i].totalPoint().toString()) ?? 0)} VNĐ",
                                          style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BillDetailCubit, BillDetailCubitState>(
        builder: (context, state) {
          return Container(
            height: 200,
            padding: const EdgeInsets.only(left: 37, right: 37, top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thành tiền:",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                    Text(
                      "${formatNumber(int.parse(state.billModel.total.toString()) - 30000)} VNĐ",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phương thức thanh toán:",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                    Text(
                      "Tiền mặt",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phí vận chuyển:",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                    Text(
                      "30.000 VNĐ",
                      style: TextStyle(color: colorMain, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(height: 2, color: Color(0xFF9D9D9D)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thành tiền:",
                      style: TextStyle(color: Color.fromARGB(255, 4, 4, 4), fontSize: 16),
                    ),
                    Text(
                      "${formatNumber(int.tryParse(state.billModel.total.toString()) ?? 0)} VNĐ",
                      style: const TextStyle(fontSize: 16, color: Color(0xFFDF0000)),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
