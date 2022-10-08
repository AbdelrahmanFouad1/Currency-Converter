import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {


  const CountryModel({
    required String currencyId,
    required String currencyName,
    required String name,
    required String alpha3,
    required String id,
    required String currencySymbol,
  }) : super(
          currencyId: currencyId,
          currencyName: currencyName,
          name: name,
          alpha3: alpha3,
          id: id,
          currencySymbol: currencySymbol,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      currencyId: json['currencyId'] ?? '',
      currencyName: json['currencyName'] ?? '',
      name: json['name'] ?? '',
      alpha3: json['alpha3'] ?? '',
      id: json['id'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencyId': currencyId,
      'currencyName': currencyName,
      'name': name,
      'alpha3': alpha3,
      'id': id,
      'currencySymbol': currencySymbol,
    };
  }
}
