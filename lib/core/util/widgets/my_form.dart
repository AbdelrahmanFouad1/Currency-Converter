import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/extensions_manager.dart';
import '../resources/font_manager.dart';

class MyForm extends StatefulWidget {
  final String label;
  TextEditingController? controller;
  final TextInputType type;
  String? error;
  final bool isPassword;
  final bool readOnly;

  MyForm({
    Key? key,
    required this.label,
    this.controller,
    this.type = TextInputType.text,
    this.error,
    this.isPassword = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: ColorsManager.darkGrey,
            fontSize: 24.0.rSp,
            fontWeight: FontWeightManager.semiBold,
          ),
      enableInteractiveSelection: false,
      showCursor: false,
      readOnly: widget.readOnly,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.error;
        }

        return null;
      },
      keyboardType: widget.type,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0.rSp),
        focusedBorder: null,
        fillColor: ColorsManager.textFillColor,
        filled: true,
        hintText: widget.label,
        hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: ColorsManager.regularGrey,
              fontSize: 24.0.rSp,
              fontWeight: FontWeightManager.semiBold,
            ),
        enabledBorder: OutlineInputBorder(
          // borderSide: BorderSide(
          //   color: ColorsManager.regularGrey,
          //   width: 1.0.rSp,
          // ),
          borderSide: BorderSide.none,
          borderRadius: borderRadius(18.0.rSp),
        ),
        // enabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.regularGrey,
            width: 1.0.rSp,
          ),
          // borderSide: BorderSide.none,
          borderRadius: borderRadius(18.0.rSp),
        ),
      ),
    );
  }
}
