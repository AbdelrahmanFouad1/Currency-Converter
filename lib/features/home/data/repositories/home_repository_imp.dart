import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/countries_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/countries_model.dart';

typedef CallCountries = Future<CountriesModel> Function();
typedef CallConverter = Future<Map<String, num>> Function();

class HomeRepoImplementation extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, CountriesEntity>> fetchCountries(
    CallCountries mainMethod,
  ) async {
    try {
      final loginData = await mainMethod();
      return Right(loginData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
        message: e.message,
      ));
    }
  }

  Future<Either<Failure, Map<String, num>>> fetchConvert(
    CallConverter mainMethod,
  ) async {
    try {
      final loginData = await mainMethod();
      return Right(loginData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CountriesEntity>> getCountries() async {
    return await fetchCountries(() {
      return remoteDataSource.getCountries();
    });
  }

  @override
  Future<Either<Failure, Map<String, num>>> convert({
    required String from,
    required String to,
  }) async {
    return await fetchConvert(() {
      return remoteDataSource.convert(
        from: from,
        to: to,
      );
    });
  }
}
