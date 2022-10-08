import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/font_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../widgets/currency_history_widget.dart';
import '/core/util/widgets/main_scaffold.dart';

class CurrencyHistoryPage extends StatelessWidget {
  const CurrencyHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      mobileScaffold: Scaffold(
        backgroundColor: ColorsManager.lightGrey,
        appBar: AppBar(
          backgroundColor: ColorsManager.lightGrey,
          title: Text(
            appTranslation().currencyHistory,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeightManager.regular,
                  fontSize: 18.0.rSp,
                ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.secondary,
            ),
          ),
        ),
        body: const CurrencyHistoryWidget(),
      ),
    );
  }
}
