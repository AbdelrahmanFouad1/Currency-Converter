import 'package:currency/features/currency_history/data/models/currency_history_model.dart';
import 'package:currency/features/currency_history/domain/repositories/currency_history_repository.dart';
import 'package:currency/features/currency_history/domain/usecases/currency_history_usecase.dart';
import 'package:currency/features/home/domain/repositories/home_repository.dart';
import 'package:currency/features/home/domain/usecases/convert_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_history_usecase_test.mocks.dart';

@GenerateMocks([CurrencyHistoryRepository])
void main() {
  late MockCurrencyHistoryRepository mockCountriesRepository;
  late CurrencyHistoryUseCase useCase;
  late CurrencyHistoryModel tCurrencyHistory;
  late String tFrom;
  late String tTo;
  late String tDate;
  late String tEndDate;


  setUp(() {
    mockCountriesRepository = MockCurrencyHistoryRepository();
    useCase = CurrencyHistoryUseCase(mockCountriesRepository);
    tCurrencyHistory = CurrencyHistoryModel(record: [
      Tuple2(DateTime(2022, 9, 19), 19.257151),
      Tuple2(DateTime(2022, 9, 20), 19.440642),
      Tuple2(DateTime(2022, 9, 21), 19.479599),
      Tuple2(DateTime(2022, 9, 22), 19.489096),
      Tuple2(DateTime(2022, 9, 23), 19.49533),
      Tuple2(DateTime(2022, 9, 24), 19.612983),
      Tuple2(DateTime(2022, 9, 25), 19.615029),
      Tuple2(DateTime(2022, 9, 26), 19.562596),
    ]);

    tFrom = 'USD';
    tTo = 'EGP';
    tDate = '2022-09-19';
    tEndDate = '2022-09-26';
  });



  test('should get currency history from the repositories', () async {
    // arrange
    when(mockCountriesRepository.currencyHistory(
      from: tFrom,
      to: tTo,
      date: tDate,
      endDate: tEndDate,
    )).thenAnswer((_) async => Right(tCurrencyHistory));

    // act
    final result = await useCase( CurrencyHistoryParams(
      from: tFrom,
      to: tTo,
      date: tDate,
      endDate: tEndDate,
    ));

    // assert
    expect(result, equals(Right(tCurrencyHistory)));
    verify(mockCountriesRepository.currencyHistory(
      from: tFrom,
      to: tTo,
      date: tDate,
      endDate: tEndDate,
    ));
    verifyNoMoreInteractions(mockCountriesRepository);
  });
}
