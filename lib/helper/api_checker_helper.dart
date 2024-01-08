import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/api_response_model.dart';
import 'package:flutter_restaurant/common/models/error_response_model.dart';
import 'package:flutter_restaurant/localization/app_localization.dart';
import 'package:flutter_restaurant/main.dart';
import 'package:flutter_restaurant/helper/router_helper.dart';
import 'package:flutter_restaurant/helper/custom_snackbar_helper.dart';
import 'package:provider/provider.dart';

class ApiCheckerHelper {
  static void checkApi(ApiResponseModel apiResponse,{bool firebaseResponse = false} ) {
    ErrorResponseModel error = getError(apiResponse);
    if( error.errors![0].code == '401' || error.errors![0].code == 'auth-001'
        && ModalRoute.of(Get.context!)?.settings.name != RouterHelper.loginScreen) {


    }else {
      showCustomSnackBarHelper(firebaseResponse ? error.errors?.first.message?.replaceAll('_', ' ').toCapitalized() : error.errors!.first.message);
    }
  }

  static ErrorResponseModel getError(ApiResponseModel apiResponse){
    ErrorResponseModel error;

    try{
      error = ErrorResponseModel.fromJson(apiResponse);
    }catch(e){
      if(apiResponse.error is String){
        error = ErrorResponseModel(errors: [Errors(code: '', message: apiResponse.error.toString())]);

      }else{
        error = ErrorResponseModel.fromJson(apiResponse.error);
      }
    }
    return error;
  }
}