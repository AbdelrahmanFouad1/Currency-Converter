import 'dart:convert';

import 'package:currency/features/home/data/models/countries_model.dart';
import 'package:currency/features/home/data/models/country_model.dart';
import 'package:currency/features/home/domain/entities/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tCountryModel = CountryModel(
      alpha3: "EGY",
      currencyId: "EGP",
      currencyName: "Egyptian pound",
      currencySymbol: "£",
      id: "EG",
      name: "Egypt"
  );

  test(
    'should be a subclass of CountriesEntity entity',
    () async {
      // assert
      expect(tCountryModel, isA<CountryEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('country.json'));
        // act
        final result = CountryModel.fromJson(jsonMap);
        // assert
        expect(result, tCountryModel);
      },
    );
  });


  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCountryModel.toJson();
        // assert
        final expectedJsonMap = {
          "alpha3": "EGY",
          "currencyId": "EGP",
          "currencyName": "Egyptian pound",
          "currencySymbol": "£",
          "id": "EG",
          "name": "Egypt"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
