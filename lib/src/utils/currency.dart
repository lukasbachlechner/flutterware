import 'package:intl/intl.dart';

String formatCurrency(double input) {
  return NumberFormat.simpleCurrency().format(input);
}
