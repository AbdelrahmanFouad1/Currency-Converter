import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/util/cubit/cubit.dart';
import '/core/util/cubit/state.dart';
import 'internet_connection.dart';

class MainScaffold extends StatelessWidget {
  final Widget? webScaffold;
  final Widget mobileScaffold;

  const MainScaffold({
    Key? key,
    this.webScaffold,
    required this.mobileScaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Directionality(
          textDirection: AppBloc.get(context).isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: AppBloc.get(context).isAppConnected? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 1270) {
                return webScaffold!;
              }

              return mobileScaffold;
            },
          ) : const InternetConnection(),
        );
      },
    );
  }
}
