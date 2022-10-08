// Mocks generated by Mockito 5.3.2 from annotations
// in currency/test/features/currency_history/data/repositories/currency_history_repository_imp_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:currency/features/currency_history/data/datasources/currency_history_remote_data_source.dart'
    as _i3;
import 'package:currency/features/currency_history/data/models/currency_history_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCurrencyHistoryModel_0 extends _i1.SmartFake
    implements _i2.CurrencyHistoryModel {
  _FakeCurrencyHistoryModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CurrencyHistoryRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyHistoryRemoteDataSource extends _i1.Mock
    implements _i3.CurrencyHistoryRemoteDataSource {
  MockCurrencyHistoryRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.CurrencyHistoryModel> currencyHistory({
    required String? from,
    required String? to,
    required String? date,
    required String? endDate,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #currencyHistory,
          [],
          {
            #from: from,
            #to: to,
            #date: date,
            #endDate: endDate,
          },
        ),
        returnValue: _i4.Future<_i2.CurrencyHistoryModel>.value(
            _FakeCurrencyHistoryModel_0(
          this,
          Invocation.method(
            #currencyHistory,
            [],
            {
              #from: from,
              #to: to,
              #date: date,
              #endDate: endDate,
            },
          ),
        )),
      ) as _i4.Future<_i2.CurrencyHistoryModel>);
}

/// A class which mocks [CurrencyHistoryRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyHistoryRemoteDataSourceForTest extends _i1.Mock
    implements _i3.CurrencyHistoryRemoteDataSource {
  @override
  _i4.Future<_i2.CurrencyHistoryModel> currencyHistory({
    required String? from,
    required String? to,
    required String? date,
    required String? endDate,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #currencyHistory,
          [],
          {
            #from: from,
            #to: to,
            #date: date,
            #endDate: endDate,
          },
        ),
        returnValue: _i4.Future<_i2.CurrencyHistoryModel>.value(
            _FakeCurrencyHistoryModel_0(
          this,
          Invocation.method(
            #currencyHistory,
            [],
            {
              #from: from,
              #to: to,
              #date: date,
              #endDate: endDate,
            },
          ),
        )),
      ) as _i4.Future<_i2.CurrencyHistoryModel>);
}
