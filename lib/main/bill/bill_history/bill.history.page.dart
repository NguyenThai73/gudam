import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/component/loading/loading.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'bill.history.cubit.dart';
import 'bill.history.cubit.state.dart';

class BillHistoryPage extends StatelessWidget {
  const BillHistoryPage({super.key});

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
          "Lịch sử trạng thái",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF325A3E)),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BillHistoryCubit, BillHistoryCubitState>(
        listener: (context, state) {
          if (state.status == BillHistoryStatus.loading) {
            context.read<LoadingCubit>().makeLoading();
          } else {
            context.read<LoadingCubit>().hideLoading();
          }
        },
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: state.listHistory
                      .map((element) => Container(
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${listTrangthai[element.status ?? 0]}",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${element.descriptionBill}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(element.createdDate??"").toLocal()),
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ));
        },
      ),
    );
  }
}

Map<int, String> listTrangthai = {
  0: 'Chờ xác nhận',
  1: 'Đang giao',
  2: 'Đã giao',
  3: 'Hoàn/huỷ',
};
