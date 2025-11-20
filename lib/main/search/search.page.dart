// ignore_for_file: prefer_const_constructors

import 'package:app_dong_ho/constants/style.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/button.not.click.multi.dart';
import '../../constants/clock.item.dart';
import 'search.cubit.dart';
import 'search.cubit.state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool find = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchCubitState>(
      builder: (context, state) {
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
            title: state.clockTypeModel != null
                ? Text(
                    "${state.clockTypeModel?.name}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorMain),
                  )
                : null,
            centerTitle: true,
            actions: [
              ButtonNotClickMulti(
                onTap: () {},
                child: Icon(
                  Icons.sort,
                  size: 30,
                  color: colorMain,
                ),
              ),
              SizedBox(width: 16)
            ],
          ),
          body: ButtonNotClickMulti(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFEFEAEA),
                          ),
                          padding: EdgeInsets.only(right: 10),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                find = true;
                              });
                            },
                            controller: context.read<SearchCubit>().searchController,
                            decoration: InputDecoration(
                              hintText: "Tìm kiếm cây",
                              helperStyle: TextStyle(fontSize: 14, color: Color(0xFF999898)),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xFF999898),
                                  )),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 85,
                        height: 50,
                        decoration: BoxDecoration(color: colorMain, borderRadius: BorderRadius.circular(5)),
                        child: ButtonNotClickMulti(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                find = false;
                              });
                              context.read<SearchCubit>().findClock();
                            },
                            child: const Center(
                              child: Text(
                                "Tìm kiếm",
                                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 5),
                  find
                      ? Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tìm kiếm gần đây",
                                style: TextStyle(fontSize: 16, color: Color(0xFFA5AFA8)),
                              ),
                              SizedBox(height: 10),
                              state.listHistoryFind.isNotEmpty
                                  ? ChipsChoice<int>.single(
                                      value: 0,
                                      onChanged: (val) {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        setState(() {
                                          find = false;
                                        });
                                        context.read<SearchCubit>().findClockHistory(state.listHistoryFind[val]);
                                      },
                                      choiceItems: C2Choice.listFrom<int, String>(
                                        source: state.listHistoryFind,
                                        value: (i, v) => i,
                                        label: (i, v) => v,
                                        tooltip: (i, v) => v,
                                        delete: (i, v) => () {
                                          context.read<SearchCubit>().removeHistory(state.listHistoryFind[i]);
                                        },
                                      ),
                                      choiceStyle: C2ChipStyle.toned(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      wrapped: true,
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  !find
                      ? Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: SingleChildScrollView(
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: state.listClocks.map((e) {
                                    double width = 0;
                                    var widthScreen = MediaQuery.of(context).size.width / 2 - 20;
                                    if (widthScreen > 206) {
                                      width = 206;
                                    } else {
                                      width = widthScreen;
                                    }
                                    return SizedBox(
                                      height: 206,
                                      child: ClockItem(
                                        width: width,
                                        clock: e,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )))
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
