import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/widgets/my_button.dart';
import '../bloc/home_cubit.dart';
import 'currency_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/resources/colors_manager.dart';
import '../bloc/home_state.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    HomeBloc.get(context).getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20.0.rSp),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: CurrencyContainer(
                    countryText: appTranslation().selectCurrencyType,
                    valueText: appTranslation().enterYourCurrency,
                    selectedCountry:
                        HomeBloc.get(context).selectedFirstCountryModel,
                    controller: HomeBloc.get(context).firstCountryController,
                    onChanged: (value) {
                      HomeBloc.get(context).changeFirstCountry = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0.rSp),
                  child: CircleAvatar(
                    backgroundColor: ColorsManager.white,
                    radius: 20.0.rSp,
                    child: IconButton(
                      onPressed: () {
                        HomeBloc.get(context).swapCountries();
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_up_arrow_down,
                        size: 20.0.rSp,
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                ),
                CurrencyContainer(
                  countryText: appTranslation().selectConverterCurrencyType,
                  valueText: appTranslation().enterConverterCurrency,
                  selectedCountry:
                      HomeBloc.get(context).selectedSecondCountryModel,
                  onChanged: (value) {
                    HomeBloc.get(context).changeSecondCountry = value;
                  },
                  controller: HomeBloc.get(context).secondCountryController,
                  isSecond: true,
                ),
                verticalSpace(40.0.rSp),
                MyButton(
                  isLoading: state is ConverterLoading,
                  onPressed: () {
                    if (HomeBloc.get(context).selectedFirstCountryModel !=
                            null &&
                        HomeBloc.get(context).selectedSecondCountryModel !=
                            null) {
                      if (formKey.currentState!.validate()) {
                        HomeBloc.get(context).converter();
                      }
                    } else {
                      designToastDialog(
                          context: context,
                          toast: TOAST.warning,
                          text: appTranslation().pleaseFillEmptyFields);
                    }
                  },
                  text: appTranslation().convert,
                  textColor: ColorsManager.white,
                  height: 50.0.rSp,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
