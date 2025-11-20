import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main/bill/tabs/cancel.tab.dart';
import 'package:app_dong_ho/main/bill/tabs/delivering.tab.dart';
import 'package:app_dong_ho/main/cart/cart.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'list.bill.cubit.dart';
import 'list.bill.cubit.state.dart';
import 'tabs/processing.tab.dart';
import 'tabs/received.tab.dart';

class ListBillPage extends StatelessWidget {
  const ListBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBillCubit, ListBillCubitState>(
      builder: (context, state) {
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
                  const Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Đơn hàng",
                          style: TextStyle(fontSize: 24, color: Color(0xFF325A3E), fontWeight: FontWeight.w700),
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
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<ListBillCubit>().changePageNumber(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2, color: state.tabNumber == 0 ? const Color(0xFF325A3E) : Colors.white))),
                        child: Center(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Đang xử lý",
                            style: state.tabNumber == 0
                                ? const TextStyle(color: Color(0xFF325A3E), fontSize: 16, fontWeight: FontWeight.bold)
                                : const TextStyle(color: Color(0xFFA5AFA8), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<ListBillCubit>().changePageNumber(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2, color: state.tabNumber == 1 ? const Color(0xFF325A3E) : Colors.white))),
                        child: Center(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Đang giao",
                            style: state.tabNumber == 1
                                ? const TextStyle(color: Color(0xFF325A3E), fontSize: 16, fontWeight: FontWeight.bold)
                                : const TextStyle(color: Color(0xFFA5AFA8), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<ListBillCubit>().changePageNumber(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2, color: state.tabNumber == 2 ? const Color(0xFF325A3E) : Colors.white))),
                        child: Center(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Đã giao",
                            style: state.tabNumber == 2
                                ? const TextStyle(color: Color(0xFF325A3E), fontSize: 16, fontWeight: FontWeight.bold)
                                : const TextStyle(color: Color(0xFFA5AFA8), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<ListBillCubit>().changePageNumber(3);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3, color: state.tabNumber == 3 ? const Color(0xFF325A3E) : Colors.white))),
                        child: Center(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            "Hoàn/huỷ",
                            style: state.tabNumber == 3
                                ? const TextStyle(color: Color(0xFF325A3E), fontSize: 16, fontWeight: FontWeight.bold)
                                : const TextStyle(color: Color(0xFFA5AFA8), fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: const Color(0xFFF4F4F4),
              ),
              Expanded(
                  child: PageView(
                controller: context.read<ListBillCubit>().pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProcessingTab(
                    listBill: state.listBill,
                  ),
                  DeliveringTab(
                    listBill: state.listBill,
                  ),
                  ReceivedTab(
                    listBill: state.listBill,
                  ),
                  CancelTab(
                    listBill: state.listBill,
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
