import 'package:dartz/dartz.dart';

import '../../domain/entities/currency_history_entity.dart';

class CurrencyHistoryModel extends CurrencyHistoryEntity {
  const CurrencyHistoryModel({
    required List<Tuple2<DateTime, num>> record,
  }) : super(
          record: record,
        );

  factory CurrencyHistoryModel.fromJson(Map<String, dynamic> json) {
    return CurrencyHistoryModel(
      // parse results as map string dynamic

      record: json.keys
          .map<Tuple2<DateTime, num>>(
            (key) => Tuple2(
              DateTime.tryParse(key) ?? DateTime.now(),
              json[key],
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'record': record,
    };
  }
}
