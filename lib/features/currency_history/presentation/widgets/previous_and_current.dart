import 'package:flutter/material.dart';

import '../../../../core/util/resources/assets_manager.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/font_manager.dart';
import '../../../../core/util/widgets/my_svg.dart';
import '../../../home/domain/entities/country_entity.dart';

class PreviousAndCurrent extends StatelessWidget {
  const PreviousAndCurrent({
    Key? key,
    required this.previousFirst,
    required this.currentSecond,
  }) : super(key: key);

  final CountryEntity previousFirst;
  final CountryEntity currentSecond;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.00.rSp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      previousFirst.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 22.rSp,
                            fontWeight: FontWeightManager.medium,
                            color: ColorsManager.darkGrey,
                          ),
                    ),
                    verticalSpace(8.0.rSp),
                    RichText(
                      textWidthBasis: TextWidthBasis.parent,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: previousFirst.currencyName.substring(
                              0,
                              previousFirst.currencyName.length < 16
                                  ? previousFirst.currencyName.length
                                  : 16),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 12.rSp,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorsManager.darkGrey,
                                  ),
                          children: [
                            TextSpan(
                              text: '  ${previousFirst.currencySymbol}',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 12.rSp,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorsManager.darkGrey,
                                      ),
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RotatedBox(
              quarterTurns: 2,
              child: MySvg(image: AssetsManager.arrowLeft),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentSecond.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 22.rSp,
                            fontWeight: FontWeightManager.medium,
                            color: ColorsManager.primary,
                          ),
                    ),
                    verticalSpace(8.rSp),
                    RichText(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: currentSecond.currencyName.substring(
                              0,
                              currentSecond.currencyName.length < 16
                                  ? currentSecond.currencyName.length
                                  : 16),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 12.rSp,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorsManager.primary,
                                  ),
                          children: [
                            TextSpan(
                              text: '  ${currentSecond.currencySymbol}',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontSize: 12.rSp,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorsManager.primary,
                                      ),
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
