import '../../domain/entities/countries_entity.dart';
import 'country_model.dart';

class CountriesModel  extends CountriesEntity{

  const CountriesModel({
    required Map<String, CountryModel> results,

  }): super(
    results: results,
  );

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      // parse results as map string dynamic
      results: json['results'] != null
          ? Map<String, CountryModel>.from(json['results'].map(
              (key, value) => MapEntry(
                key,
                CountryModel.fromJson(value),
              ),
            ))
          : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results,
    };
  }
}
