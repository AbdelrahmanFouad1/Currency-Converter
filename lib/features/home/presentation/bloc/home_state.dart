import 'package:meta/meta.dart';


@immutable
abstract class HomeState {}

class Empty extends HomeState {}

class GetCountriesLoading extends HomeState {}

class GetCountriesSuccess extends HomeState {}

class GetCountriesFromCashSuccess extends HomeState {}

class GetCountriesError extends HomeState {
  final String failure;

  GetCountriesError({required this.failure});
}

class ChangeFirstCountryState extends HomeState {}

class ChangeSecondCountryState extends HomeState {}

class ConverterLoading extends HomeState {}

class ConverterSuccess extends HomeState {}

class ConverterError extends HomeState {
  final String failure;

  ConverterError({required this.failure});
}

class SwapCountriesState extends HomeState {}
