import '../../../../core/util/resources/extensions_manager.dart';
import 'currency_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/currency_history_entity.dart';
import '../../domain/usecases/currency_history_usecase.dart';

class CurrencyHistoryBloc extends Cubit<CurrencyHistoryState> {
  final CurrencyHistoryUseCase _convertUseCase;

  CurrencyHistoryBloc({
    required CurrencyHistoryUseCase convertUseCase,
  })  : _convertUseCase = convertUseCase,
        super(Empty());

  static CurrencyHistoryBloc get(context) => BlocProvider.of(context);

  /// Get currency history from API.
  ///
  /// When the request is successful calculate Currency.

  void currencyHistory({
    required String from,
    required String to,
  }) async {
    DateTime now = DateTime.now();
    DateTime lastWeek = now.subtract(const Duration(days: 7));

    emit(CurrencyHistoryLoading());

    final result = await _convertUseCase(
      CurrencyHistoryParams(
        from: from,
        to: to,
        date: lastWeek.yMd,
        endDate: now.yMd,
      ),
    );

    result.fold(
      (failure) {
        emit(CurrencyHistoryError(failure: failure.toString()));
      },
      (data) {
        emit(CurrencyHistorySuccess(history: data.record.reversed.toList()));
      },
    );
  }
}
