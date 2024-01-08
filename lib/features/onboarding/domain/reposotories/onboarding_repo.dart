import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_restaurant/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_restaurant/common/models/api_response_model.dart';
import 'package:flutter_restaurant/features/onboarding/domain/models/onboarding_model.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/utill/images.dart';

class OnBoardingRepo {
  final DioClient? dioClient;

  OnBoardingRepo({required this.dioClient});

  Future<ApiResponseModel> getOnBoardingList(BuildContext context) async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onBoardingOne, getTranslated('make_your_choice_order', context), getTranslated('you_can_choice_the_best', context)),
        OnBoardingModel(Images.onBoardingTwo, getTranslated('select_delivery_location', context), getTranslated('select_accurate_location', context)),
        OnBoardingModel(Images.onBoardingThree, getTranslated('delivery_to_your_home', context), getTranslated('get_food_delivery_at_home', context)),
      ];

      Response response = Response(requestOptions: RequestOptions(path: ''), data: onBoardingList, statusCode: 200);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
