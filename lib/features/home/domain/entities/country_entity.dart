import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String currencyId;
  final String currencyName;
  final String name;
  final String alpha3;
  final String id;
  final String currencySymbol;

  const CountryEntity({
    required this.currencyId,
    required this.currencyName,
    required this.name,
    required this.alpha3,
    required this.id,
    required this.currencySymbol,
  });

  @override
  List<Object?> get props => [
        currencyId,
        currencyName,
        name,
        alpha3,
        id,
        currencySymbol,
      ];
}
