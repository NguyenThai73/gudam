import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/component/error/error.cubit.dart';
import 'package:app_dong_ho/constants/dialog.show.image.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:app_dong_ho/main.router.constant.dart';
import 'package:app_dong_ho/main/account/dialog.change.pass.dart';
import 'package:app_dong_ho/main/cubit/user.change.cubit.dart';
import 'package:app_dong_ho/repository/authentication.repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:service_user/service_user.dart';

import 'account.cubit.dart';
import 'account.cubit.state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountCubitState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              BlocBuilder<UserChangeCubit, UserModel?>(
                builder: (context, stateUser) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 6, color: Color(0xFFE2E2E2)))),
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Column(
                          children: [
                            Image.asset("assets/background_infor.png", fit: BoxFit.fitWidth),
                          ],
                        )),
                        Positioned.fill(
                            child: Column(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1 +10, bottom: 5),
                              // child: Image,

                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(100)),
                                        child: (stateUser != null && stateUser.avatar != null && stateUser.avatar != "")
                                            ? ButtonNotClickMulti(
                                                onTap: () {
                                                  context.showDialogImage("$baseUrlImage${stateUser.avatar}");
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: "$baseUrlImage${stateUser.avatar}",
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url, error) {
                                                    return Image.asset(
                                                      "assets/noavatar.png",
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.circular(100)),
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                "assets/noavatar.png",
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Container()),
                                Text(
                                  stateUser?.fullName ?? "",
                                  style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
                                ),
                                const Expanded(
                                  child: Row(
                                    children: [
                                      // SizedBox(
                                      //   width: 30,
                                      //   height: 30,
                                      //   child: Image.asset("assets/icon_edit.png"),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              stateUser?.email ?? "",
                              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 14, bottom: 18),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                          child: ButtonNotClickMulti(
                            onTap: () async {
                              context.push(MainRouterPath.routerAccountDetail);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset("assets/user.png"),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Thông tin cá nhân",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Color(0xFF999898),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 14, bottom: 18),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
                          child: ButtonNotClickMulti(
                            onTap: () async {
                              var response = await showDialog(
                                context: context,
                                builder: (context) => const DialogChangePassword(),
                              );
                              if (response != null && response is String) {
                                var check = await context.read<AccountCubit>().changePass(password: response);
                                if (check) {
                                  context.read<ErrorCubit>().showDialog(
                                          widgetShow: Column(
                                        children: [
                                           Text(
                                            "Thay đổi mật khẩu thành công",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: colorMain, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 25),
                                          Container(
                                              height: 50,
                                              decoration:
                                                  BoxDecoration(color:  colorMain, borderRadius: BorderRadius.circular(25), boxShadow: [
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
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset("assets/lock.png"),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Đổi mật khẩu",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Color(0xFF999898),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            context.read<AuthenticationRepository>().logOut();
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: Image.asset("assets/log-out.png"),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Đăng xuất",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
