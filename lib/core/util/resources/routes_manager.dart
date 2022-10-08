import 'package:flutter/material.dart';

import '/features/home/presentation/pages/home_page.dart';
import '../../../features/currency_history/presentation/pages/currency_history_page.dart';

class Routes {
  static const String home = '/home';
  static const String currencyHistory = '/currency/history';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomePage(),
      currencyHistory: (context) => const CurrencyHistoryPage(),
    };
  }
}
