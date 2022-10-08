import 'dart:convert';

import 'package:currency/features/currency_history/data/models/currency_history_model.dart';
import 'package:currency/features/currency_history/domain/entities/currency_history_entity.dart';
import 'package:currency/features/home/data/models/country_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCurrencyHistory = CurrencyHistoryModel(record: [
    Tuple2(DateTime(2022, 9, 19), 19.257151),
    Tuple2(DateTime(2022, 9, 20), 19.440642),
    Tuple2(DateTime(2022, 9, 21), 19.479599),
    Tuple2(DateTime(2022, 9, 22), 19.489096),
    Tuple2(DateTime(2022, 9, 23), 19.49533),
    Tuple2(DateTime(2022, 9, 24), 19.612983),
    Tuple2(DateTime(2022, 9, 25), 19.615029),
    Tuple2(DateTime(2022, 9, 26), 19.562596),
  ]);

  test(
    'should be a subclass of CurrencyHistoryEntity entity',
    () async {
      // assert
      expect(tCurrencyHistory, isA<CurrencyHistoryEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('currency_history.json'));
        // act
        final result = CurrencyHistoryModel.fromJson(jsonMap);
        // assert
        expect(result, tCurrencyHistory);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCurrencyHistory.toJson();
        // assert
        final expectedJsonMap = {
          'record': {
            Tuple2(DateTime(2022, 9, 19), 19.257151),
            Tuple2(DateTime(2022, 9, 20), 19.440642),
            Tuple2(DateTime(2022, 9, 21), 19.479599),
            Tuple2(DateTime(2022, 9, 22), 19.489096),
            Tuple2(DateTime(2022, 9, 23), 19.49533),
            Tuple2(DateTime(2022, 9, 24), 19.612983),
            Tuple2(DateTime(2022, 9, 25), 19.615029),
            Tuple2(DateTime(2022, 9, 26), 19.562596),
          }
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
