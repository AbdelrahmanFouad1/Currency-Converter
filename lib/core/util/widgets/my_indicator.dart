import '/core/util/resources/colors_manager.dart';
import '/core/util/widgets/my_cupertino_indicator.dart';
import 'package:flutter/material.dart';


class MyIndicator extends StatelessWidget {
  const MyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyCupertinoActivityIndicator(
        activeColor:  ColorsManager.primary,
      ),
    );
  }
}
