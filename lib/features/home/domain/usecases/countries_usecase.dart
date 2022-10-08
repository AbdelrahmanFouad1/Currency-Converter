import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/countries_entity.dart';
import '../repositories/home_repository.dart';

class CountriesUseCase implements UseCase<CountriesEntity, NoParams> {
  final HomeRepository repository;

  CountriesUseCase(this.repository);

  @override
  Future<Either<Failure, CountriesEntity>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
