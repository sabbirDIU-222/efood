import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/api_response_model.dart';
import 'package:flutter_restaurant/features/onboarding/domain/models/onboarding_model.dart';
import 'package:flutter_restaurant/features/onboarding/domain/reposotories/onboarding_repo.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingProvider with ChangeNotifier {
  final OnBoardingRepo? onboardingRepo;
  final SharedPreferences? sharedPreferences;

  OnBoardingProvider({required this.onboardingRepo, required this.sharedPreferences}) {
    _loadShowOnBoardingStatus();
  }

  final List<OnBoardingModel> _onBoardingList = [];
  bool _showOnBoardingStatus = false;
  bool get showOnBoardingStatus => _showOnBoardingStatus;
  List<OnBoardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  changeSelectIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  void _loadShowOnBoardingStatus() async {
    _showOnBoardingStatus = sharedPreferences!.getBool(AppConstants.onBoardingSkip) ?? true;
  }
  void toggleShowOnBoardingStatus() {
    sharedPreferences!.setBool(AppConstants.onBoardingSkip, false);
  }

  void initBoardingList(BuildContext context) async {
    ApiResponseModel apiResponse = await onboardingRepo!.getOnBoardingList(context);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _onBoardingList.clear();
      _onBoardingList.addAll(apiResponse.response!.data);
      notifyListeners();
    }
  }
}
