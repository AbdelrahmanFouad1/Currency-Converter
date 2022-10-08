import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/currency_history_entity.dart';

@immutable
abstract class CurrencyHistoryState {}

class Empty extends CurrencyHistoryState {}

class CurrencyHistoryLoading extends CurrencyHistoryState {}

class CurrencyHistorySuccess extends CurrencyHistoryState {
  final List<Tuple2<DateTime, num>>  history;

  CurrencyHistorySuccess({required this.history});
}

class CurrencyHistoryError extends CurrencyHistoryState {
  final String failure;

  CurrencyHistoryError({required this.failure});
}
