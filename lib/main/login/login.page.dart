// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors
import 'package:app_dong_ho/constants/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import '../../constants/component/loading/loading.cubit.dart';
import '../../main.router.constant.dart';
import 'login.cubit.dart';
import 'login.cubit.state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSeenPass = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {
          context.read<LoadingCubit>().makeLoading();
        } else {
          context.read<LoadingCubit>().hideLoading();
        }
        if (state.status == LoginStatus.error) {
          context.read<ErrorCubit>().showDialog(
                  widgetShow: Column(
                children: [
                   Text(
                    "Tài khoản mật khẩu không đúng",
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
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ButtonNotClickMulti(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Image.asset(
                        //   "assets/login_background.png",
                        //   fit: BoxFit.fitWidth,
                        // ),Image.asset("assets/logo.jpeg")
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom: 30),
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage("assets/logo.jpeg"), fit: BoxFit.cover)),
                        ),
                        Text(
                          "Đăng nhập với tài khoản của bạn",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFa5afa8)),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                          padding: EdgeInsets.only(right: 10),
                          height: 56,
                          decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: context.read<LoginCubit>().emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                              prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.email)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 18),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                          padding: EdgeInsets.only(right: 10),
                          height: 56,
                          decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: context.read<LoginCubit>().passwordController,
                            decoration: InputDecoration(
                              hintText: "Mật khẩu",
                              helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                              prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.lock)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 18),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSeenPass = !isSeenPass;
                                  });
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Icon(
                                    isSeenPass ? Icons.visibility_off : Icons.visibility,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            obscureText: isSeenPass,
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     ButtonNotClickMulti(
                        //       onTap: () {},
                        //       child: Text(
                        //         "Quên mật khẩu ?",
                        //         style: TextStyle(fontSize: 13, color: colorMain),
                        //       ),
                        //     ),
                        //     SizedBox(width: 30),
                        //   ],
                        // ),
                        Container(
                          height: 56,
                          margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 10),
                          decoration: BoxDecoration(
                            color: colorMain,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ButtonNotClickMulti(
                            onTap: () {
                              if (context.read<LoginCubit>().passwordController.text.isEmpty ||
                                  context.read<LoginCubit>().emailController.text.isEmpty) {
                                context.read<ErrorCubit>().showDialog(
                                        widgetShow: Column(
                                      children: [
                                        Text(
                                          "Cần điền đầy đủ thông tin",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 25),
                                        Container(
                                            height: 50,
                                            decoration: BoxDecoration(color: colorMain, borderRadius: BorderRadius.circular(25), boxShadow: [
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
                              } else {
                                context.read<LoginCubit>().login();
                              }
                            },
                            child: Center(
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Bạn chưa có tài khoản? ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF999999),
                            ),
                          ),
                          TextSpan(
                            text: "Đăng ký",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: colorMain,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                context.push(MainRouterPath.routerRegister);
                              },
                          ),
                        ])),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
