import '../resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/widgets/my_cupertino_indicator.dart';

import '../resources/constants_manager.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  double width;
  double height;
  bool isLoading;
  Color? color;
  Color? textColor;

  MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 70.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color ?? ColorsManager.primary,
        borderRadius: borderRadius(18.0.rSp),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        height: height,
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: textColor,
                  ),
            ),
            if (isLoading) horizontalSpace(10.rSp),
            if (isLoading)
              const MyCupertinoActivityIndicator(
                activeColor: ColorsManager.white,
              ),
          ],
        ),
      ),
    );
  }
}
