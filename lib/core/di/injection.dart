import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';
import '/core/util/cubit/cubit.dart';
import '../../features/currency_history/data/datasources/currency_history_remote_data_source.dart';
import '../../features/currency_history/data/repositories/currency_history_repository_imp.dart';
import '../../features/currency_history/domain/repositories/currency_history_repository.dart';
import '../../features/currency_history/domain/usecases/currency_history_usecase.dart';
import '../../features/currency_history/presentation/bloc/currency_history_cubit.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_imp.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/convert_usecase.dart';
import '../../features/home/domain/usecases/countries_usecase.dart';
import '../../features/home/presentation/bloc/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
    () => AppBloc(),
  );

  sl.registerLazySingleton(
    () => HomeBloc(
      convertUseCase: sl(),
      countriesUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CurrencyHistoryBloc(
      convertUseCase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepoImplementation(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CurrencyHistoryRepository>(
    () => CurrencyHistoryRepoImplementation(
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CountriesUseCase(sl()));

  sl.registerLazySingleton(() => ConvertUseCase(sl()));

  sl.registerLazySingleton(() => CurrencyHistoryUseCase(sl()));

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      dioHelper: sl(),
    ),
  );

  sl.registerLazySingleton<CurrencyHistoryRemoteDataSource>(
    () => CurrencyHistoryRemoteDataSourceImpl(
      dioHelper: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
