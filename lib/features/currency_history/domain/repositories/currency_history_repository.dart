import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/currency_history_entity.dart';

abstract class CurrencyHistoryRepository {
  Future<Either<Failure, CurrencyHistoryEntity>> currencyHistory({
    required String from,
    required String to,
    required String date,
    required String endDate,
  });
}
