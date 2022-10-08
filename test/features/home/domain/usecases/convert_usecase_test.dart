import 'package:currency/features/home/domain/repositories/home_repository.dart';
import 'package:currency/features/home/domain/usecases/convert_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'countries_usecase_test.mocks.dart';


@GenerateMocks([HomeRepository])
void main() {
  late MockHomeRepository mockCountriesRepository;
  late ConvertUseCase useCase;
  late Map<String, num> tConvertModel;
  late String tFrom;
  late String tTo;


  setUp(() {
    mockCountriesRepository = MockHomeRepository();
    useCase = ConvertUseCase(mockCountriesRepository);
    tConvertModel = {'USD_EGP': 19.639102};
    tFrom = 'USD';
    tTo = 'EGP';
  });



  test('should get convert from the repositories', () async {
    // arrange
    when(mockCountriesRepository.convert(from: tFrom, to: tTo))
        .thenAnswer((_) async =>  Right(tConvertModel));

    // act
    final result = await useCase( ConvertParams(from: tFrom, to: tTo));

    // assert
    expect(result,  equals(Right(tConvertModel)));
    verify(mockCountriesRepository.convert(from: tFrom, to: tTo));
    verifyNoMoreInteractions(mockCountriesRepository);
  });
}
