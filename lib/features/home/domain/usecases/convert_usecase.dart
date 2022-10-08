import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repositories/home_repository.dart';

class ConvertUseCase implements UseCase<Map<String, num>, ConvertParams> {
  final HomeRepository repository;

  ConvertUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, num>>> call(ConvertParams params) async {
    return await repository.convert(from: params.from, to: params.to);
  }
}

class ConvertParams extends Equatable {
  final String from;
  final String to;

  const ConvertParams({
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [
    from,
    to,
  ];
}