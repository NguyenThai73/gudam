import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main.router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/button.not.click.multi.dart';

class LayoutRegister extends StatelessWidget {
  final String namePage;
  final String subPage;
  final Widget body;
  final String buttonName;
  final Function() onTap;
  const LayoutRegister({super.key, required this.body, required this.namePage, required this.subPage, required this.buttonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonNotClickMulti(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset:false,
          backgroundColor: Colors.white,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      margin: const EdgeInsets.only(top: 50, left: 25, bottom: 25),
                      decoration: BoxDecoration(color: Color(0xFFEFEAEA), borderRadius: BorderRadius.circular(20)),
                      child: ButtonNotClickMulti(
                        onTap: () {
                          context.pop();
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
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
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(namePage, style: TextStyle(fontSize: 48, color: colorMain, fontWeight: FontWeight.w700)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Expanded(child: Text(subPage, style: TextStyle(fontSize: 18, color: Color(0xFFa5afa8), fontWeight: FontWeight.w400))),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(child: body),
                Container(
                  height: 56,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: colorMain,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ButtonNotClickMulti(
                    onTap: onTap,
                    child: Center(
                      child: Text(
                        buttonName,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "Bạn đã có tài khoản ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                    ),
                  ),
                  TextSpan(
                    text: "Đăng nhập",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorMain,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        context.popUntilPath(MainRouterPath.routerLogin);
                      },
                  ),
                ])),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}
