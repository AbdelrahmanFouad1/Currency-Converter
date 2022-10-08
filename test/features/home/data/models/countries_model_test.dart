import 'dart:convert';

import 'package:currency/features/home/data/models/countries_model.dart';
import 'package:currency/features/home/data/models/country_model.dart';
import 'package:currency/features/home/domain/entities/countries_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tCountriesModel = CountriesModel(results: {
    "KW": CountryModel(
      alpha3: "KWT",
      currencyId: "KWD",
      currencyName: "Kuwaiti dinar",
      currencySymbol: "د.ك",
      id: "KW",
      name: "Kuwait",
    ),
    "EG": CountryModel(
      alpha3: "EGY",
      currencyId: "EGP",
      currencyName: "Egyptian pound",
      currencySymbol: "£",
      id: "EG",
      name: "Egypt",
    )
  });

  test(
    'should be a subclass of CountriesEntity entity',
    () async {
      // assert
      expect(tCountriesModel, isA<CountriesEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('countries.json'));
        // act
        final result = CountriesModel.fromJson(jsonMap);
        // assert
        expect(result, tCountriesModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCountriesModel.toJson();
        // assert
        final expectedJsonMap = {
          'results': {
            "KW": const CountryModel(
              alpha3: "KWT",
              currencyId: "KWD",
              currencyName: "Kuwaiti dinar",
              currencySymbol: "د.ك",
              id: "KW",
              name: "Kuwait",
            ),
            "EG": const CountryModel(
              alpha3: "EGY",
              currencyId: "EGP",
              currencyName: "Egyptian pound",
              currencySymbol: "£",
              id: "EG",
              name: "Egypt",
            )
          }
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
