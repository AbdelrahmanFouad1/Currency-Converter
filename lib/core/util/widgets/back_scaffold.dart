import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/util/resources/constants_manager.dart';
import '/core/util/cubit/cubit.dart';
import '/core/util/cubit/state.dart';
import '/core/util/widgets/my_svg.dart';

class BackScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  double elevation;

  BackScaffold({
    Key? key,
    required this.body,
    required this.title,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: MySvg(
                image: 'left-arrow',
                color: Theme.of(context).colorScheme.secondary,
                rotate: true,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            elevation: elevation,
            shadowColor: Colors.grey[100],
          ),
          body: body,
        );
      },
    );
  }
}
