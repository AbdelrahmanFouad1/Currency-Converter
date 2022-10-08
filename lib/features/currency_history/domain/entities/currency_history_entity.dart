import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CurrencyHistoryEntity extends Equatable {
  final List<Tuple2<DateTime, num>> record;


  const CurrencyHistoryEntity({
    required this.record,
  });

  @override
  List<Object?> get props => [
    record,
  ];
}
