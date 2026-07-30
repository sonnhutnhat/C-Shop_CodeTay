import 'package:intl/intl.dart';

abstract final class CShopFormat {
  static final _currency = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  static String currency(num value) => _currency.format(value);
}
