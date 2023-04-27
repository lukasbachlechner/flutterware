import 'package:intl/intl.dart';

String formatCurrency(double input) {
  if (input == 0) {
    return 'Free';
  }

  return NumberFormat.simpleCurrency(
    name: 'EUR',
    locale: 'de_AT',
  ).format(input);
}
