import 'package:dio/dio.dart';

import '../../../../core/network/remote/api_endpoints.dart';
import '../../../../core/network/remote/dio_helper.dart';
import '../models/countries_model.dart';

abstract class HomeRemoteDataSource {
  Future<CountriesModel> getCountries();

  Future<Map<String, num>> convert({
    required String from,
    required String to,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<CountriesModel> getCountries() async {
    final Response f = await dioHelper.get(
      url: countryUrl,
      query: {
        'apiKey': apiKey,
      },
    );
    return CountriesModel.fromJson(f.data);
  }

  @override
  Future<Map<String, num>> convert({
    required String from,
    required String to,
  }) async {
    final Response f = await dioHelper.get(
      url: convertUrl,
      query: {
        'q': '${from}_$to',
        'compact': 'ultra',
        'apiKey': apiKey,
      },
    );
    return f.data.map<String, num>(
      (key, value) => MapEntry<String, num>(
        key,
        value,
      ),
    );
  }
}
