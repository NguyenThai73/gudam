// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/format.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_clock/service_clock.dart';

import 'cart.cubit.dart';
import 'cart.cubit.state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartCubitState>(
      builder: (context, state) {
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
            title:  Text(
              "Giỏ hàng",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorMain),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  for (int i = 0; i < state.listCart.length; i++)
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                      child: Slidable(
                        key: ValueKey("cart:${state.listCart[i].id}"),
                        endActionPane: ActionPane(
                          motion: Container(
                            margin: const EdgeInsets.only(left: 15),
                            height: 100,
                            width: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDF0505),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ButtonNotClickMulti(
                              onTap: () {},
                              child: const Center(
                                child: Text(
                                  "Xoá",
                                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          children: [],
                        ),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: (state.listCart[i].clock?.listImage().first != null && state.listCart[i].clock?.listImage().first != "")
                                    ? CachedNetworkImage(
                                        imageUrl: "$baseUrlImage${state.listCart[i].clock?.listImage().first}",
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                            image: DecorationImage(image: AssetImage("assets/clock.jpeg"), fit: BoxFit.cover),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                            image: DecorationImage(image: AssetImage("assets/clock.jpeg"), fit: BoxFit.cover),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                          image: DecorationImage(image: AssetImage("assets/clock.jpeg"), fit: BoxFit.cover),
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Text(
                                          state.listCart[i].clock?.name ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "${formatNumber(int.tryParse(state.listCart[i].clock?.price.toString()??"") ?? 0)} VNĐ",
                                          style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5), border: Border.all(color: colorMain)),
                                            child: InkWell(
                                                onTap: () {
                                                  context.read<CartCubit>().removeNumberCart(i);
                                                },
                                                child: const Center(
                                                  child: Text("-"),
                                                )),
                                          ),
                                          const SizedBox(width: 12),
                                          Text("${state.listCart[i].number}"),
                                          const SizedBox(width: 12),
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5), border: Border.all(color: colorMain)),
                                            child: InkWell(
                                                onTap: () {
                                                  context.read<CartCubit>().addNumberCart(i);
                                                },
                                                child: const Center(
                                                  child: Text("+"),
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: state.listSelected[i] == true ? colorMain : const Color(0xFFB8B8B8),
                                    borderRadius: BorderRadius.circular(4)),
                                margin: const EdgeInsets.only(right: 25, left: 10),
                                child: InkWell(
                                  onTap: () {
                                    context.read<CartCubit>().handleSelected(i);
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 223,
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
                      "${formatNumber(state.total)} đ",
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
                      "30.000 đ",
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
                      "${formatNumber(state.total + 30000)} VNĐ",
                      style: const TextStyle(fontSize: 16, color: Color(0xFFDF0000)),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 50,
                  decoration: BoxDecoration(color:  colorMain, borderRadius: BorderRadius.circular(25), boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: const Offset(0, 7), // changes position of shadow
                    ),
                  ]),
                  child: ButtonNotClickMulti(
                      onTap: () async {
                        DataSendBill dataSendBill = DataSendBill(listCart: [], billModel: BillModel(listDetail: []));
                        List<BillDetailModel> listDetail = [];
                        for (int i = 0; i < state.listCart.length; i++) {
                          if (state.listSelected[i] == true) {
                            listDetail.add(BillDetailModel(
                                idClock: state.listCart[i].clock?.id ?? 0, clock: state.listCart[i].clock, number: state.listCart[i].number));
                            dataSendBill.listCart.add(state.listCart[i]);
                          }
                        }
                        dataSendBill.billModel = BillModel(
                          idUser: context.read<AuthenticationRepository>().currentUser?.id ?? 0,
                          listDetail: listDetail,
                          total: state.total + 30000,
                          status: 0,
                          methodPayment: 0,
                        );
                        context.push(MainRouterPath.routerPayment, extra: dataSendBill);
                      },
                      child: const Center(
                        child: Text(
                          "Đặt hàng",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DataSendBill {
  List<CartItem> listCart;
  BillModel billModel;
  DataSendBill({
    required this.listCart,
    required this.billModel,
  });

  DataSendBill copyWith({
    List<CartItem>? listCart,
    BillModel? billModel,
  }) {
    return DataSendBill(
      listCart: listCart ?? this.listCart,
      billModel: billModel ?? this.billModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listCart': listCart.map((x) => x.toMap()).toList(),
      'billModel': billModel.toMap(),
    };
  }

  factory DataSendBill.fromMap(Map<String, dynamic> map) {
    return DataSendBill(
      listCart: List<CartItem>.from(
        (map['listCart'] as List<int>).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      billModel: BillModel.fromMap(map['billModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataSendBill.fromJson(String source) => DataSendBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
