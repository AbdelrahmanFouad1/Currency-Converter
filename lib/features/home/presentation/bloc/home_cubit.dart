import 'home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/usecases/convert_usecase.dart';
import '../../domain/usecases/countries_usecase.dart';

class HomeBloc extends Cubit<HomeState> {
  final CountriesUseCase _countriesUseCase;
  final ConvertUseCase _convertUseCase;

  HomeBloc({
    required CountriesUseCase countriesUseCase,
    required ConvertUseCase convertUseCase,
  })  : _countriesUseCase = countriesUseCase,
        _convertUseCase = convertUseCase,
        super(Empty());

  static HomeBloc get(context) => BlocProvider.of(context);

  /// Get All Countries From API.
  ///
  /// When the request is successful but data in [countriesEntity],
  /// and cashed data in local [ConstantsManger.countriesEntity].
  Map<String, CountryEntity>? countriesEntity;

  void getCountries() async {
    if (ConstantsManger.countriesEntity == null) {
      emit(GetCountriesLoading());
      final result = await _countriesUseCase(NoParams());
      result.fold(
        (failure) => emit(GetCountriesError(failure: failure.toString())),
        (data) async {
          // save list of countryEntity in cashed data in local.
          countriesEntity = data.results;
          await sl<CacheHelper>().put('countries', data.results).then((value) {
            debugPrint('countries saved in cache');
          }).catchError((error) {
            debugPrint('error in saving countries in cache $error');
          });
          emit(GetCountriesSuccess());
        },
      );
    } else {
      emit(GetCountriesFromCashSuccess());
    }
  }

  /// Change First Country.
  ///
  /// Select Country From List [countryEntity],
  /// and set it in [selectedFirstCountryModel].
  CountryEntity? selectedFirstCountryModel;

  set changeFirstCountry(CountryEntity model) {
    // 1. Set Selected Country.
    selectedFirstCountryModel = model;

    // 2. Clear two controller.
    firstCountryController.clear();
    secondCountryController.clear();
    emit(ChangeFirstCountryState());
  }

  /// Change second Country.
  ///
  /// Select Country From List [countryEntity],
  /// and set it in [selectedFirstCountryModel].
  CountryEntity? selectedSecondCountryModel;

  set changeSecondCountry(CountryEntity model) {
    // 1. Set Selected Country.
    selectedSecondCountryModel = model;

    // 2. Clear secondary controller.
    secondCountryController.clear();
    emit(ChangeSecondCountryState());
  }

  /// Swap Between First And Second Country.
  ///
  /// When user click on [CircleAvatar] in [HomeWidget],
  /// this function will be called.
  void swapCountries() async {
    // 1.Swipe between two models.
    final temp = selectedFirstCountryModel;
    selectedFirstCountryModel = selectedSecondCountryModel;
    selectedSecondCountryModel = temp;

    if (firstCountryController.text.isNotEmpty &&
        secondCountryController.text.isNotEmpty) {
      // 2.Swipe between two controllers.
      final temp = firstCountryController.text;
      firstCountryController.text = secondCountryController.text;
      secondCountryController.text = temp;
    }

    emit(SwapCountriesState());
  }

  /// Get currency from API.
  ///
  /// When the request is successful calculate Currency.
  void converter() async {
    emit(ConverterLoading());

    final result = await _convertUseCase(
      ConvertParams(
        from: selectedFirstCountryModel!.currencyId,
        to: selectedSecondCountryModel!.currencyId,
      ),
    );

    result.fold(
      (failure) => emit(ConverterError(failure: failure.toString())),
      (data) => calculateCurrency = data.values.first,
    );
  }

  /// Calculate Currency.
  ///
  /// Calculate Currency From [firstCountryController] and [converter],
  /// and set it in [secondCountryController].
  TextEditingController firstCountryController = TextEditingController();

  set calculateCurrency(num converter) {
    final firstCountryValue = num.parse(firstCountryController.text);
    final result = firstCountryValue * converter;
    debugPrint('calculateCurrency $result');
    calculateCurrencyInSecondController = result;
  }

  /// But calculateCurrency in [secondCountryController].
  TextEditingController secondCountryController = TextEditingController();

  set calculateCurrencyInSecondController(num value) {
    debugPrint('calculateCurrencyInSecondController $value');
    secondCountryController.text = value.toStringAsFixed(3);
    emit(ConverterSuccess());
  }
}
