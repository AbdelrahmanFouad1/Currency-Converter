import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/countries_entity.dart';

abstract class HomeRepository {

  Future<Either<Failure, CountriesEntity>> getCountries();

  Future<Either<Failure, Map<String, num>>> convert({
    required String from,
    required String to,
  });
}
