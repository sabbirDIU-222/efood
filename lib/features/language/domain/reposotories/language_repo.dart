import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/language_model.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
