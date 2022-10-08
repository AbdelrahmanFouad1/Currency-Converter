import 'dart:async';
import 'extensions_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../features/home/data/models/country_model.dart';
import '../../../features/home/domain/entities/country_entity.dart';
import '../../di/injection.dart';
import '../../network/local/cache_helper.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/cubit/cubit.dart';
import '/core/util/resources/translation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/state.dart';
import 'assets_manager.dart';
import 'font_manager.dart';

class ConstantsManger {
  static Map<String, CountryEntity>? countriesEntity;
}

bool isArabic = true;

/// Translate error message
const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

void navigateTo<T>(context, String routeName, {T? arg}) => Navigator.pushNamed(
      context,
      routeName,
      arguments: arg,
    );

void navigateAndFinish<T>(context, String routeName, {T? arg}) =>
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arg,
    );

void popUntil(context, String routeName) => Navigator.popUntil(
      context,
      ModalRoute.withName(routeName),
    );

String localised({
  required BuildContext context,
  required String ar,
  required String en,
}) {
  if (AppBloc.get(context).isArabic) {
    return ar;
  }
  return en;
}

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

TranslationModel appTranslation() => LanguageManager.translationModel;

class PhoneCodeModel {
  final String code;
  final String countryAr;
  final String countryEn;
  final String icon;

  PhoneCodeModel({
    required this.code,
    required this.countryAr,
    required this.countryEn,
    required this.icon,
  });
}

List<PhoneCodeModel> cities = [
  PhoneCodeModel(
    code: '+971',
    countryAr: 'الإمارات',
    countryEn: 'UAE',
    icon: 'united-arab-emirates',
  ),
  PhoneCodeModel(
    code: '+20',
    countryAr: 'مصر',
    countryEn: 'Egypt',
    icon: 'egypt',
  ),
];

void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 1.0,
          color: AppBloc.get(context).isDark
              ? ColorsManager.textPrimaryBlue
              : ColorsManager.textPrimaryBlue,
        );
      },
    );
  }
}

void startTimer(context) {
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
}

Future<void> designToastDialog({
  required BuildContext context,
  required TOAST toast,
  String text = '',
  bool isDismissible = true,
}) async {
  return showDialog(
    barrierDismissible: isDismissible,
    context: context,
    builder: (context) => Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Directionality(
        textDirection: AppBloc.get(context).isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          height: 80.0,
          color: ColorsManager.white,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10.0,
                    height: double.infinity,
                    color: chooseColor(toast),
                  ),
                  horizontalSpace(20.rSp),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: chooseColor(toast),
                    child: Icon(
                      chooseIcon(toast),
                      color: ColorsManager.white,
                      size: 18.0,
                    ),
                  ),
                  horizontalSpace(20.rSp),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chooseTitle(toast, context),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: ColorsManager.darkGrey,
                                    fontWeight: FontWeightManager.bold,
                                    fontSize: 18.0.rSp,
                                  ),
                        ),
                        verticalSpace(4.rSp),
                        Text(
                          text.isNotEmpty
                              ? text
                              : appTranslation().deleteMessage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: ColorsManager.darkGrey,
                              fontWeight: FontWeightManager.regular,
                              fontSize: 14.0.rSp),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(20.rSp),
                ],
              ),
              if (isDismissible)
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: EdgeInsets.all(10.rSp),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        //navigateAndFinish(context, const MainPage());
                      },
                      child: const CircleAvatar(
                        backgroundColor: ColorsManager.surfaceLight,
                        radius: 10.0,
                        child: Icon(
                          Icons.close,
                          size: 10.0,
                          color: ColorsManager.textPrimaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

enum TOAST { success, error, info, warning }

IconData chooseIcon(TOAST toast) {
  late IconData iconData;

  switch (toast) {
    case TOAST.success:
      iconData = FontAwesomeIcons.check;
      break;
    case TOAST.error:
      iconData = FontAwesomeIcons.times;
      break;
    case TOAST.info:
      iconData = FontAwesomeIcons.info;
      break;
    case TOAST.warning:
      iconData = FontAwesomeIcons.exclamation;
      break;
  }

  return iconData;
}

Color chooseColor(TOAST toast) {
  late Color color;

  switch (toast) {
    case TOAST.success:
      color = ColorsManager.success;
      break;
    case TOAST.error:
      color = ColorsManager.error;
      break;
    case TOAST.info:
      color = ColorsManager.info;
      break;
    case TOAST.warning:
      color = ColorsManager.warning;
      break;
  }

  return color;
}

String chooseTitle(TOAST toast, context) {
  late String title;

  switch (toast) {
    case TOAST.success:
      title = appTranslation().success;
      break;
    case TOAST.error:
      title = appTranslation().error;
      break;
    case TOAST.info:
      title = appTranslation().info;
      break;
    case TOAST.warning:
      title = appTranslation().warning;
      break;
  }

  return title;
}

SizedBox verticalSpace(double size) => SizedBox(height: size);

SizedBox horizontalSpace(double size) => SizedBox(width: size);

BorderRadius borderRadius(double radius) => BorderRadius.circular(radius);

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) =>
    AppBloc.get(context).isArabic ? ar : en;
