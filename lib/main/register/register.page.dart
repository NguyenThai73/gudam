// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../constants/button.not.click.multi.dart';
import '../../constants/component/error/error.cubit.dart';
import 'layout.register.dart';
import 'register.cubit.dart';
import 'register.cubit.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isSeenPass = true;

  @override
  Widget build(BuildContext context) {
    return LayoutRegister(
      namePage: "Đăng ký!",
      subPage: "Tạo tài khoản mới của bạn!",
      body: BlocBuilder<RegisterCubit, RegisterCubitState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  padding: EdgeInsets.only(right: 10),
                  height: 56,
                  decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: context.read<RegisterCubit>().nameController,
                    decoration: InputDecoration(
                      hintText: "Họ tên",
                      helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                      prefixIcon: Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.person)),
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
                    controller: context.read<RegisterCubit>().emailController,
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
                    controller: context.read<RegisterCubit>().passwordController,
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
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  padding: EdgeInsets.only(right: 10),
                  height: 56,
                  decoration: BoxDecoration(color: Color(0xFFE1E5E2), borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: context.read<RegisterCubit>().comfirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "Xác nhận mật khẩu",
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
              ],
            ),
          );
        },
      ),
      buttonName: "Xác nhận",
      onTap: () async {
        if (context.read<RegisterCubit>().nameController.text.isEmpty ||
            context.read<RegisterCubit>().passwordController.text.isEmpty ||
            context.read<RegisterCubit>().comfirmPasswordController.text.isEmpty ||
            context.read<RegisterCubit>().emailController.text.isEmpty) {
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
        } else if (context.read<RegisterCubit>().passwordController.text.length < 5 ||
            context.read<RegisterCubit>().comfirmPasswordController.text != context.read<RegisterCubit>().passwordController.text) {
          context.read<ErrorCubit>().showDialog(
                  widgetShow: Column(
                children: [
                   Text(
                    "Mật khẩu nhỏ hơn 6 ký tự hoặc nhập lại mật khẩu không khớp",
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
        } else {
          context.read<AuthenticationRepository>().register(
              email: context.read<RegisterCubit>().emailController.text,
              password: context.read<RegisterCubit>().passwordController.text,
              name: context.read<RegisterCubit>().nameController.text);
        }
      },
    );
  }
}

class DataRegister {
  final String name;
  final String email;
  final String password;
  DataRegister({required this.name, required this.email, required this.password});
}
