import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/format.dart';
import 'package:app_dong_ho/constants/my.dialog.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_bill/service_bill.dart';

import '../list.bill.cubit.dart';

class ProcessingTab extends StatelessWidget {
  final List<BillModel> listBill;
  const ProcessingTab({super.key, required this.listBill});

  @override
  Widget build(BuildContext context) {
    return listBill.isNotEmpty
        ? SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                for (int i = 0; i < listBill.length; i++)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24, bottom: 22),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 10, color: Color(0xFFF4F4F4)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: (listBill[i].listDetail.first.clock != null &&
                                          listBill[i].listDetail.first.clock!.listImage().isNotEmpty &&
                                          listBill[i].listDetail.first.clock?.listImage().first != "")
                                      ? CachedNetworkImage(
                                          imageUrl: "$baseUrlImage${listBill[i].listDetail.first.clock?.listImage().first}",
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
                                    Text("${listBill[i].listDetail.first.clock?.name}",
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${formatNumber(int.tryParse(listBill[i].listDetail.first.clock!.price.toString()) ?? 0)} VNĐ",
                                          style: const TextStyle(fontSize: 14, color: Color(0xFFDF0000)),
                                        ),
                                        Text("x${listBill[i].listDetail.first.number}", style: const TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${formatNumber(int.tryParse(listBill[i].listDetail.first.totalPoint().toString()) ?? 0)} VNĐ",
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
                        Container(
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFEEEEEE)))),
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Tổng tiền (4 sản phẩm):"),
                              Text(
                                "${formatNumber(int.tryParse(listBill[i].total.toString()) ?? 0)} VNĐ",
                                style: const TextStyle(fontSize: 16, color: Color(0xFFDF0000)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFEEEEEE)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                width: 128,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: colorMain,
                                    )),
                                child: ButtonNotClickMulti(
                                  onTap: () async {
                                    var response = await showDialog(
                                      context: context,
                                      builder: (context) => const DialogCancelBill(),
                                    );
                                    if (response != null && response is String) {
                                      context.read<ListBillCubit>().cancelBill(i,response);
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Hủy đơn",
                                      style: TextStyle(fontSize: 14, color: Color(0xFF325A3E)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                width: 128,
                                height: 30,
                                decoration: BoxDecoration(color: colorMain, borderRadius: BorderRadius.circular(6)),
                                child: ButtonNotClickMulti(
                                  onTap: () {
                                    context.push(MainRouterPath.routerBillDetail, extra: listBill[i]);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Xem chi tiết",
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          )
        : Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 2 - 50),
             
              const Text("Bạn chưa có đơn hàng nào!", style: TextStyle(fontSize: 15))
            ],
          );
  }
}

class DialogCancelBill extends StatefulWidget {
  const DialogCancelBill({super.key});

  @override
  State<DialogCancelBill> createState() => _DialogCancelBillState();
}

class _DialogCancelBillState extends State<DialogCancelBill> {
  TextEditingController lyDo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      child: Column(
        children: [
           Text(
            "Bạn có chắc chắn muốn huỷ đơn hàng không?",
            textAlign: TextAlign.center,
            style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Container(
            height: 56,
            decoration: BoxDecoration(color: const Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: lyDo,
              decoration: const InputDecoration(
                hintText: "Lý do",
                helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(25), boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: const Offset(0, 7), // changes position of shadow
                      ),
                    ]),
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.pop();
                      },
                      child: const Center(
                        child: Text(
                          "Trở lại",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
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
                      onTap: () {
                        context.pop(lyDo.text);
                      },
                      child: const Center(
                        child: Text(
                          "Huỷ",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
