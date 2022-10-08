import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/di/injection.dart' as di;
import '/core/di/injection.dart';
import '/core/network/local/cache_helper.dart';
import '/core/util/cubit/cubit.dart';
import '/core/util/cubit/state.dart';
import '/core/util/resources/bloc_observer_manager.dart';
import 'core/util/resources/constants_manager.dart';
import 'core/util/resources/routes_manager.dart';
import 'features/currency_history/presentation/bloc/currency_history_cubit.dart';
import 'features/home/data/models/country_model.dart';
import 'features/home/domain/entities/country_entity.dart';
import 'features/home/presentation/bloc/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  bool isRtl = false;
  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('rtl ------------- $value');
    if (value != null) {
      isRtl = value;
    }

    isArabic = isRtl;
  });

  await sl<CacheHelper>().get('countries').then((value) {
    if (value != null) {
      ConstantsManger.countriesEntity = value.map<String, CountryEntity>(
          (key, v) =>
              MapEntry<String, CountryEntity>(key, CountryModel.fromJson(v)));
    }
    debugPrint(
        'List of cashed countries ------------- ${ConstantsManger.countriesEntity}');
  });

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isRtl: isRtl,
    translation: translation,
  ));
}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;

  const MyApp({
    Key? key,
    required this.isRtl,
    required this.translation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppBloc>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )
            ..connectivityListener(),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CurrencyHistoryBloc>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Currency Converter',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppBloc.get(context).lightTheme,
            initialRoute: Routes.home,
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
