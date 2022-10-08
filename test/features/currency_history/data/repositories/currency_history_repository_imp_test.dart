import 'package:currency/features/currency_history/data/datasources/currency_history_remote_data_source.dart';
import 'package:currency/features/currency_history/data/models/currency_history_model.dart';
import 'package:currency/features/currency_history/data/repositories/currency_history_repository_imp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_history_repository_imp_test.mocks.dart';


@GenerateMocks([
  CurrencyHistoryRemoteDataSource
], customMocks: [
  MockSpec<CurrencyHistoryRemoteDataSource>(
      as: #MockCurrencyHistoryRemoteDataSourceForTest, returnNullOnMissingStub: true),
])
void main() {
  late CurrencyHistoryRepoImplementation repository;
  late MockCurrencyHistoryRemoteDataSource mockCurrencyHistoryRemoteDataSource;

  setUp(() {
    mockCurrencyHistoryRemoteDataSource = MockCurrencyHistoryRemoteDataSource();
    repository = CurrencyHistoryRepoImplementation(
      remoteDataSource: mockCurrencyHistoryRemoteDataSource,
    );
  });

  group('currencyHistory', () {
    String tFrom= 'USD';
    String tTo = 'EGP';
    String tDate = '2022-09-19';
    String tEndDate = '2022-09-26';
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
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockCurrencyHistoryRemoteDataSource.currencyHistory(from: tFrom, to: tTo, date: tDate, endDate: tEndDate))
          .thenAnswer((_) async => tCurrencyHistory);
      //act
      final result = await repository.currencyHistory(from: tFrom, to: tTo, date: tDate, endDate: tEndDate);
      //assert
      verify(mockCurrencyHistoryRemoteDataSource.currencyHistory(from: tFrom, to: tTo, date: tDate, endDate: tEndDate));
      expect(result, equals(Right(tCurrencyHistory)));
    });
  });
}
