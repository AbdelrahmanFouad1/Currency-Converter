import 'package:currency/core/usecase/use_case.dart';
import 'package:currency/features/home/data/models/countries_model.dart';
import 'package:currency/features/home/data/models/country_model.dart';
import 'package:currency/features/home/domain/entities/countries_entity.dart';
import 'package:currency/features/home/domain/repositories/home_repository.dart';
import 'package:currency/features/home/domain/usecases/countries_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'countries_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockCountriesRepository;
  late CountriesUseCase useCase;
  late CountriesEntity tCountriesModel;

  setUp(() {
    mockCountriesRepository = MockHomeRepository();
    useCase = CountriesUseCase(mockCountriesRepository);
     tCountriesModel = const CountriesEntity(results: {
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
  });



  test('should get countries from the repositories', () async {
    // arrange
    when(mockCountriesRepository.getCountries())
        .thenAnswer((_) async =>  Right(tCountriesModel));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, equals( Right(tCountriesModel)));
    verify(mockCountriesRepository.getCountries());
    verifyNoMoreInteractions(mockCountriesRepository);
  });
}
