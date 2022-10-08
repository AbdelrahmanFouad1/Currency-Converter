import 'package:flutter/material.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/font_manager.dart';
import '../../../../core/util/widgets/my_form.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/home_cubit.dart';

class CurrencyContainer extends StatelessWidget {
  final bool isSecond;
  final String countryText;
  final String valueText;
  final CountryEntity? selectedCountry;
  final void Function(CountryEntity) onChanged;

  final TextEditingController? controller;

  const CurrencyContainer({
    Key? key,
    this.isSecond = false,
    required this.countryText,
    required this.valueText,
    this.selectedCountry,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0.rSp, vertical: 20.0.rSp),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: borderRadius(18.0.rSp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            countryText,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeightManager.medium,
                  color: ColorsManager.darkGrey,
                  fontSize: 14.0.rSp,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0.rSp),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0.rSp),
                focusedBorder: null,
                fillColor: ColorsManager.textFillColor,
                filled: true,
                hintText: 'Select Country',
                hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: ColorsManager.regularGrey,
                      fontSize: 18.0.rSp,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                prefixIcon: selectedCountry != null
                    ? Image.network(
                        'https://flagcdn.com/24x18/${selectedCountry!.id.toLowerCase()}.png',
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: borderRadius(18.0.rSp),
                ),
                // enabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.regularGrey,
                    width: 1.0.rSp,
                  ),
                  // borderSide: BorderSide.none,
                  borderRadius: borderRadius(18.0.rSp),
                ),
              ),
              onChanged: (CountryEntity? value) {
                onChanged(value!);
              },
              onTap: () {
                debugPrint('onTap');
              },
              value: selectedCountry,
              borderRadius: borderRadius(18.0.rSp),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 20.rSp,
              ),
              items: HomeBloc.get(context).countriesEntity != null
                  ? HomeBloc.get(context)
                      .countriesEntity!
                      .values
                      .map<DropdownMenuItem<CountryEntity>>(
                          (CountryEntity value) {
                      return DropdownMenuItem<CountryEntity>(
                        value: value,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.48,
                          child: Text(
                            value.currencyName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: ColorsManager.darkGrey,
                                  fontSize: 18.0.rSp,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                          ),
                        ),
                      );
                    }).toList()
                  : (ConstantsManger.countriesEntity != null &&
                          HomeBloc.get(context).countriesEntity == null)
                      ? ConstantsManger.countriesEntity!.values
                          .map<DropdownMenuItem<CountryEntity>>(
                              (CountryEntity value) {
                          return DropdownMenuItem<CountryEntity>(
                            value: value,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Text(
                                value.currencyName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      color: ColorsManager.darkGrey,
                                      fontSize: 18.0.rSp,
                                      fontWeight: FontWeightManager.semiBold,
                                    ),
                              ),
                            ),
                          );
                        }).toList()
                      : null,
            ),
          ),
          verticalSpace(8.0.rSp),
          Text(
            valueText,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeightManager.medium,
                  color: ColorsManager.darkGrey,
                  fontSize: 14.0.rSp,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0.rSp),
            child: Row(
              children: [
                if (selectedCountry != null) ...[
                  Text(
                    selectedCountry!.currencySymbol,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeightManager.bold,
                          color: ColorsManager.regularGrey,
                          fontSize: 20.0.rSp,
                        ),
                  ),
                  horizontalSpace(12.0.rSp),
                ],
                Expanded(
                  child: MyForm(
                    label: '0.0',
                    error: appTranslation().pleaseEnterCurrency,
                    controller: controller,
                    type: TextInputType.number,
                    readOnly: isSecond ? true : false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
