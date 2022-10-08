import 'package:currency/core/util/resources/constants_manager.dart';
import 'package:currency/features/home/data/datasources/home_remote_data_source.dart';
import 'package:currency/features/home/data/models/countries_model.dart';
import 'package:currency/features/home/data/models/country_model.dart';
import 'package:currency/features/home/data/repositories/home_repository_imp.dart';
import 'package:currency/features/home/domain/entities/countries_entity.dart';
import 'package:currency/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_imp_test.mocks.dart';

@GenerateMocks([
  HomeRemoteDataSource
], customMocks: [
  MockSpec<HomeRemoteDataSource>(
      as: #MockHomeRemoteDataSourceForTest, returnNullOnMissingStub: true),
])
void main() {
  late HomeRepoImplementation repository;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepoImplementation(
      remoteDataSource: mockHomeRemoteDataSource,
    );
  });

  group('getCountries', () {
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
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockHomeRemoteDataSource.getCountries())
          .thenAnswer((_) async => tCountriesModel);
      //act
      final result = await repository.getCountries();
      //assert
      verify(mockHomeRemoteDataSource.getCountries());
      expect(result, equals(const Right(tCountriesModel)));
    });
  });

  group('convertCurrency', () {
    String tFrom= 'USD';
    String tTo = 'EGP';
    Map<String, num> tConvertModel = {'${tFrom}_$tTo': 19.639102};

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockHomeRemoteDataSource.convert(from: tFrom, to: tTo))
          .thenAnswer((_) async => tConvertModel);
      //act
      final result = await repository.convert(from: tFrom, to: tTo);
      //assert
      verify(mockHomeRemoteDataSource.convert(from: tFrom, to: tTo));
      expect(result, equals(Right(tConvertModel)));
    });
  });
}
