import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/extensions_manager.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AssetsManager.noInternet),
            verticalSpace(10.rSp),
            Text(
              appTranslation().internetConnection,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorsManager.darkGrey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
