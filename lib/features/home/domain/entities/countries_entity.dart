import 'country_entity.dart';
import 'package:equatable/equatable.dart';

class CountriesEntity extends Equatable {
  final Map<String, CountryEntity> results;

  const CountriesEntity({
    required this.results,
  });

  @override
  List<Object?> get props => [
        results,
      ];
}
