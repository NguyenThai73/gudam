import 'package:intl/intl.dart';

final NumberFormat formatter = NumberFormat("#,###");

String formatNumber(int number) {
  final NumberFormat formatter = NumberFormat("#,###");
  return formatter.format(number);
}
