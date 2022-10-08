import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/currency_history_entity.dart';
import '../../domain/repositories/currency_history_repository.dart';
import '../datasources/currency_history_remote_data_source.dart';

typedef Call = Future<CurrencyHistoryEntity> Function();

class CurrencyHistoryRepoImplementation extends CurrencyHistoryRepository {
  final CurrencyHistoryRemoteDataSource remoteDataSource;

  CurrencyHistoryRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, CurrencyHistoryEntity>> fetchData(
    Call mainMethod,
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
  Future<Either<Failure, CurrencyHistoryEntity>> currencyHistory({
    required String from,
    required String to,
    required String date,
    required String endDate,
  }) async {
    return await fetchData(() {
      return remoteDataSource.currencyHistory(
        from: from,
        to: to,
        date: date,
        endDate: endDate,
      );
    });
  }
}
