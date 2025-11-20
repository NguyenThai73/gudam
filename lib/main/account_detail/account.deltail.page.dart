// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:app_dong_ho/confing.dart';
import 'package:app_dong_ho/constants/button.not.click.multi.dart';
import 'package:app_dong_ho/constants/component/loading/loading.cubit.dart';
import 'package:app_dong_ho/constants/dialog.show.image.dart';
import 'package:app_dong_ho/constants/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'account.deltail.cubit.dart';
import 'account.deltail.cubit.state.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountDetailCubit, AccountDetailCubitState>(
      builder: (context, state) {
        return ButtonNotClickMulti(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
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
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom: 5),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(100)),
                                        child: (state.avatar != "")
                                            ? ButtonNotClickMulti(
                                                onTap: () {
                                                  context.showDialogImage("$baseUrlImage${state.avatar}");
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl: "$baseUrlImage${state.avatar}",
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url, error) {
                                                    return Image.asset(
                                                      "assets/noavatar.png",
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius: BorderRadius.circular(100),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                "assets/noavatar.png",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Positioned.fill(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ButtonNotClickMulti(
                                          onTap: () async {
                                            context.read<LoadingCubit>().makeLoading();
                                            var avatarNew = await handleUploadAvater();
                                            if (avatarNew != null) {
                                              context.read<AccountDetailCubit>().changeAvatar(avatarNew);
                                            }
                                            context.read<LoadingCubit>().hideLoading();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 30,
                                            height: 30,
                                            child: Image.asset("assets/icon_camera.png"),
                                          ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          )),
                          Positioned.fill(
                              child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.3 - 120, left: 16),
                            child: Row(
                              children: [
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
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6)))),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "Họ tên",
                                        style: TextStyle(fontSize: 14, color: Color(0xFFA6ABC4)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: TextField(
                                      style: const TextStyle(color: Color(0xFF43484B), fontSize: 16),
                                      controller: context.read<AccountDetailCubit>().nameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(bottom: 5),
                                      ),
                                      onChanged: (value) {
                                        context.read<AccountDetailCubit>().changeFulName();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6)))),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              "Giới tính",
                                              style: TextStyle(fontSize: 14, color: Color(0xFFA6ABC4)),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height:10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                  height: 35,
                                                  child: DropdownButton(
                                                    style: const TextStyle(color: Color(0xFF43484B), fontSize: 16),
                                                    value: context.read<AccountDetailCubit>().listGender.first,
                                                    icon: const Row(
                                                      children: [
                                                        SizedBox(width: 40),
                                                        Icon(Icons.arrow_drop_down),
                                                      ],
                                                    ),
                                                    elevation: 16,
                                                    onChanged: (String? value) {
                                                      context.read<AccountDetailCubit>().changeGioiTinh(value ?? "Nam");
                                                    },
                                                    items:
                                                        context.read<AccountDetailCubit>().listGender.map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    underline: Container(
                                                      height: 0,
                                                      color: const Color.fromARGB(0, 214, 214, 214),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6)))),
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              "Số điện thoại",
                                              style: TextStyle(fontSize: 14, color: Color(0xFFA6ABC4)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 35,
                                          child: TextField(
                                            controller: context.read<AccountDetailCubit>().sdtcontroller,
                                            style: const TextStyle(color: Color(0xFF43484B), fontSize: 16),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(bottom: 0),
                                            ),
                                            onChanged: (value) {
                                              context.read<AccountDetailCubit>().changeSdt();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6)))),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "Địa chỉ",
                                        style: TextStyle(fontSize: 14, color: Color(0xFFA6ABC4)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: context.read<AccountDetailCubit>().addressController,
                                      style: const TextStyle(color: Color(0xFF43484B), fontSize: 16),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(bottom: 5),
                                      ),
                                      onChanged: (value) {
                                        context.read<AccountDetailCubit>().changeAddress();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                      await context.read<AccountDetailCubit>().updateProfile();
                      context.pop();
                    },
                    child: const Center(
                      child: Text(
                        "Lưu",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ));
      },
    );
  }
}

Future<String?> handleUploadAvater() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null) {
    try {
      for (var element in result.files) {
        String path = element.path ?? "";
        var fileNameUpload = await uploadFile(File(path));
        fileName = fileNameUpload;
      }
    } catch (e) {
      print("Loi upload: $e");
    }
  } else {}

  return fileName;
}

Future<String?> uploadFile(File file) async {
  try {
    Map<String, String> headers = {'content-type': 'application/json'};
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("http://localhost:8080/api/upload"),
    );
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        'file', // Field name in the form-data
        http.ByteStream(file.openRead()),
        await file.length(),
        filename: 'file.jpg',
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var body = json.decode(responseBody);
      return body["1"];
    } else {
      return null;
    }
  } catch (e) {
    print("Loi tai: $e");
    return null;
  }
}
