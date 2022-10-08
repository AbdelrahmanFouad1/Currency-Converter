
import '/core/util/resources/translation_manager.dart';

const String imagePath = "assets/images";
const String iconPath = "assets/icons";
const String svgPath = ".svg";
const String png = ".png";
const String jpg = ".jpg";
const String json = ".json";

class AssetsManager {

  /// SVG Images
  static const String arrowLeft = '$iconPath/arrow_left$svgPath';


  /// PNG images
  // static const String logoMPng = '$imagePath/logo_m$png';


  /// Json File
  static const String noInternet = '$imagePath/no_internet$json';

}

class LanguageManager{
  static  String lang = 'ar';
  static late TranslationModel translationModel;
}