// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:service_clock/service_clock.dart';

class DataPageModel {
  String pageName;
  List<ClockModel> listData;
  DataPageModel({
    required this.pageName,
    required this.listData,
  });
}
