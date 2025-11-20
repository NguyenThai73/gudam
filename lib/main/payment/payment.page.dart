import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/component/error/error.cubit.dart';
import 'package:app_dong_ho/constants/component/loading/loading.cubit.dart';
import 'package:app_dong_ho/constants/my.dialog.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main/cart/cart.cubit.dart';
import 'package:app_dong_ho/main/cubit/user.change.cubit.dart';
import 'package:app_dong_ho/main/payment/payment.succes.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_user/service_user.dart';

import 'payment.cubit.dart';
import 'payment.cubit.state.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentCubitState>(
      listener: (context, statePayment) {
        if (statePayment.status == PaymentStatus.loading) {
          context.read<LoadingCubit>().makeLoading();
        } else {
          context.read<LoadingCubit>().hideLoading();
        }
        if (statePayment.status == PaymentStatus.error) {
          context.read<ErrorCubit>().showDialog(
                  widgetShow: Column(
                children: [
                   Text(
                    "Có lỗi xảy ra",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Container(
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
                          context.pop(true);
                        },
                        child: const Center(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                ],
              ));
        }
        if (statePayment.status == PaymentStatus.success) {
          context.read<CartCubit>().deleteCart(listCartRemove: context.read<PaymentCubit>().dataSendBill.listCart);
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const PaymentSuccesPage(),
            ),
          );
          //
        }
      },
      builder: (context, state) {
        return BlocBuilder<UserChangeCubit, UserModel?>(
          builder: (context, stateUser) {
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
                    "Thanh toán",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF325A3E)),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "Địa chỉ giao hàng",
                          style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Image.asset(
                              "assets/location.png",
                              width: 50,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(stateUser?.fullName ?? "Chưa có tên",
                                      style:  TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text("${stateUser?.sdt != null ? stateUser!.sdt : "Chưa có"}",
                                      style: const TextStyle(color: Color(0xFF666666), fontSize: 14)),
                                  Text("${stateUser?.address != null ? stateUser!.address : "Chưa có"}",
                                      style: const TextStyle(color: Color(0xFF666666), fontSize: 14)),
                                ],
                              ),
                            ),
                            ButtonNotClickMulti(
                              onTap: () {
                                context.push(MainRouterPath.routerAccountDetail);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 164, 164, 164),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                         Text(
                          "Phương thức thanh toán",
                          style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 2, color: colorMain),
                              color: const Color(0xFFF0F0F0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Image.asset("assets/tien_mat.png", width: 40),
                                  const SizedBox(width: 15),
                                   Text("Thanh toán bằng tiền mặt", style: TextStyle(color: colorMain, fontSize: 16)),
                                ],
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(color: colorMain, borderRadius: BorderRadius.circular(30)),
                                margin: const EdgeInsets.only(right: 15),
                                child: InkWell(
                                  onTap: () {},
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
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  margin: const EdgeInsets.only(bottom: 25, left: 16, right: 16),
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
                        if (stateUser?.fullName == null || stateUser?.sdt == null || stateUser?.address == null) {
                          var response = await showDialog(
                            context: context,
                            builder: (context) => MyDialog(
                              child: Column(
                                children: [
                                   Text(
                                    "Bạn cần nhập đủ thông tin số điện thoại, địa chỉ để có thể thanh toán",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
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
                                          context.pop(true);
                                        },
                                        child: const Center(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                          if (response != null && response == true) {
                            context.push(MainRouterPath.routerAccountDetail);
                          }
                        } else {
                          context.read<PaymentCubit>().buyClock();
                        }
                      },
                      child: const Center(
                        child: Text(
                          "Thanh toán",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )),
                ));
          },
        );
      },
    );
  }
}
