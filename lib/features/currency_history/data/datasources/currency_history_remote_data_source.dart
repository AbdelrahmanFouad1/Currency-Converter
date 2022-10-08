import 'package:dio/dio.dart';

import '../../../../core/network/remote/api_endpoints.dart';
import '../../../../core/network/remote/dio_helper.dart';
import '../models/currency_history_model.dart';

abstract class CurrencyHistoryRemoteDataSource {
  Future<CurrencyHistoryModel> currencyHistory({
    required String from,
    required String to,
    required String date,
    required String endDate,
  });
}

class CurrencyHistoryRemoteDataSourceImpl
    implements CurrencyHistoryRemoteDataSource {
  final DioHelper dioHelper;

  CurrencyHistoryRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<CurrencyHistoryModel> currencyHistory({
    required String from,
    required String to,
    required String date,
    required String endDate,
  }) async {
    final Response f = await dioHelper.get(
      url: convertUrl,
      query: {
        'q': '${from}_$to',
        'compact': 'ultra',
        'apiKey': apiKey,
        'date': date,
        'endDate': endDate,
      },
    );

    final json = ((f.data as Map).values.first as Map)
        .map<String, num>((k, v) => MapEntry(k, v));
    return CurrencyHistoryModel.fromJson(json);
  }
}
