import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/util/widgets/hide_keyboard_page.dart';
import '/core/util/widgets/main_scaffold.dart';
import '/features/home/presentation/widgets/home_widget.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/font_manager.dart';
import '../../../../core/util/resources/routes_manager.dart';
import '../bloc/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return MainScaffold(
      mobileScaffold: Scaffold(
        backgroundColor: ColorsManager.lightGrey,
        appBar: AppBar(
          backgroundColor: ColorsManager.lightGrey,
          title: Text(
            appTranslation().currencyConvert,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeightManager.regular,
                  fontSize: 18.0.rSp,
                ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                if (HomeBloc.get(context).selectedFirstCountryModel != null &&
                    HomeBloc.get(context).selectedSecondCountryModel != null) {
                  navigateTo(context, Routes.currencyHistory);
                } else {
                  designToastDialog(
                      context: context,
                      toast: TOAST.warning,
                      text: appTranslation().pleaseSelectTwoCountries);
                }
              },
              icon: const Icon(
                Icons.history_rounded,
                color: ColorsManager.secondary,
              ),
            ),
          ],
        ),
        body: HideKeyboardPage(
          child: HomeWidget(),
        ),
      ),
    );
  }
}
