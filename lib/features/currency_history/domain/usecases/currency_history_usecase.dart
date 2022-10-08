import '../repositories/currency_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/currency_history_entity.dart';

class CurrencyHistoryUseCase
    implements UseCase<CurrencyHistoryEntity, CurrencyHistoryParams> {
  final CurrencyHistoryRepository repository;

  CurrencyHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, CurrencyHistoryEntity>> call(
      CurrencyHistoryParams params) async {
    return await repository.currencyHistory(
        from: params.from,
        to: params.to,
        date: params.date,
        endDate: params.endDate);
  }
}

class CurrencyHistoryParams extends Equatable {
  final String from;
  final String to;
  final String date;
  final String endDate;

  const CurrencyHistoryParams({
    required this.from,
    required this.to,
    required this.date,
    required this.endDate,
  });

  @override
  List<Object> get props => [
        from,
        to,
        date,
        endDate,
      ];
}
