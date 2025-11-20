// ignore_for_file: deprecated_member_use
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main.router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentSuccesPage extends StatelessWidget {
  const PaymentSuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/payss.jpeg"), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, top: 50),
                width: 35,
                height: 35,
                decoration: BoxDecoration(color: const Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                child: ButtonNotClickMulti(
                  onTap: () {
                    context.popUntilPath(MainRouterPath.routerCartPage);
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
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(50), boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 14,
                        blurRadius: 9,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 93,
                          height: 93,
                          child: Image.asset("assets/done.png"),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          "Đặt hàng thành công",
                          style: TextStyle(fontSize: 20, color: colorMain, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 56,
                          margin: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: colorMain,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ButtonNotClickMulti(
                            onTap: () {
                               context.popUntilPath(MainRouterPath.routerMain);
                            },
                            child: const Center(
                              child: Text(
                                "Tiếp tục mua sắm",
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
