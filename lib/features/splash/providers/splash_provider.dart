import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/api_response_model.dart';
import 'package:flutter_restaurant/common/models/config_model.dart';
import 'package:flutter_restaurant/common/models/offline_payment_model.dart';
import 'package:flutter_restaurant/features/splash/domain/reposotories/splash_repo.dart';
import 'package:flutter_restaurant/helper/date_converter_helper.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:flutter_restaurant/helper/custom_snackbar_helper.dart';
import 'package:provider/provider.dart';

import '../../../common/models/policy_model.dart';
import '../../../helper/api_checker_helper.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;

  SplashProvider({required this.splashRepo});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;
  final DateTime _currentTime = DateTime.now();
  PolicyModel? _policyModel;
  bool _cookiesShow = true;
  List<OfflinePaymentModel?>? _offlinePaymentModelList;




  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;
  DateTime get currentTime => _currentTime;
  PolicyModel? get policyModel => _policyModel;
  bool get cookiesShow => _cookiesShow;
  List<OfflinePaymentModel?>? get offlinePaymentModelList => _offlinePaymentModelList;

  int? currentDashBord = 0;


  void updateIndex(int value){
    print('----update index ---> $value');
    currentDashBord = value;
    notifyListeners();
  }



  Future<bool> initConfig(BuildContext context) async {
    ApiResponseModel apiResponse = await splashRepo!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      isSuccess = true;


      if(_configModel != null && _configModel!.branches != null && !isBranchSelectDisable()){
        await splashRepo?.setBranchId(_configModel!.branches![0]!.id!);
      }
      notifyListeners();
    } else {
      isSuccess = false;

      showCustomSnackBarHelper(ApiCheckerHelper.getError(apiResponse).errors![0].message);
    }
    return isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo!.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo!.removeSharedData();
  }

  bool isRestaurantClosed(bool today) {
    DateTime date = DateTime.now();
    if(!today) {
      date = date.add(const Duration(days: 1));
    }
    int weekday = date.weekday;
    if(weekday == 7) {
      weekday = 0;
    }
    for(int index = 0; index <  _configModel!.restaurantScheduleTime!.length; index++) {
      if(weekday.toString() ==  _configModel!.restaurantScheduleTime![index].day) {
        return false;
      }
    }
    return true;
  }

  bool isRestaurantOpenNow(BuildContext context) {
    if(isRestaurantClosed(true)) {
      return false;
    }
    int weekday = DateTime.now().weekday;
    if(weekday == 7) {
      weekday = 0;
    }
    for(int index = 0; index <  _configModel!.restaurantScheduleTime!.length; index++) {
      if(weekday.toString() ==  _configModel!.restaurantScheduleTime![index].day && DateConverterHelper.isAvailable(
            _configModel!.restaurantScheduleTime![index].openingTime!,
            _configModel!.restaurantScheduleTime![index].closingTime!,
          )) {
        return true;
      }
    }
    return false;
  }

  Future<bool> getPolicyPage() async {
    ApiResponseModel apiResponse = await splashRepo!.getPolicyPage();
    bool isSuccess;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _policyModel = PolicyModel.fromJson(apiResponse.response!.data);
      isSuccess = true;
      notifyListeners();
    } else {
      isSuccess = false;
      ApiCheckerHelper.checkApi(apiResponse);
    }

    return isSuccess;
  }

  void cookiesStatusChange(String? data) {
    if(data != null){
      splashRepo!.sharedPreferences!.setString(AppConstants.cookiesManagement, data);
    }
    _cookiesShow = false;
    notifyListeners();
  }

  bool getAcceptCookiesStatus(String? data) => splashRepo!.sharedPreferences!.getString(AppConstants.cookiesManagement) != null
      && splashRepo!.sharedPreferences!.getString(AppConstants.cookiesManagement) == data;

  int getActiveBranch(){
    int branchActiveCount = 0;
    for(int i = 0; i < _configModel!.branches!.length; i++){
      if(_configModel!.branches![i]!.status ?? false) {
        branchActiveCount++;
        if(branchActiveCount > 1){
          break;
        }
      }
    }
    if(branchActiveCount == 0){
       splashRepo?.setBranchId(-1);
    }
    return branchActiveCount;
  }

  bool isBranchSelectDisable()=> getActiveBranch() != 1;

  Future<void> getOfflinePaymentMethod(bool isReload) async {
    if(_offlinePaymentModelList == null || isReload){
      _offlinePaymentModelList = null;
    }
    if(_offlinePaymentModelList == null){
      ApiResponseModel apiResponse = await splashRepo!.getOfflinePaymentMethod();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _offlinePaymentModelList = [];

        apiResponse.response?.data.forEach((v) {
          _offlinePaymentModelList?.add(OfflinePaymentModel.fromJson(v));
        });

      } else {
        ApiCheckerHelper.checkApi(apiResponse);
      }
      notifyListeners();
    }

  }

}