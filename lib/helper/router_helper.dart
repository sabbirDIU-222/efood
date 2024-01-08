import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/models/product_model.dart';
import 'package:flutter_restaurant/features/home/screens/home_screen.dart';
import 'package:flutter_restaurant/features/language/screens/choose_language_screen.dart';
import 'package:flutter_restaurant/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter_restaurant/features/splash/screens/splash_screen.dart';
import 'package:flutter_restaurant/features/welcome/screens/welcome_screen.dart';
import 'package:flutter_restaurant/helper/responsive_helper.dart';
import 'package:flutter_restaurant/main.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:go_router/go_router.dart';

enum RouteAction{push, pushReplacement, popAndPush, pushNamedAndRemoveUntil}

class RouterHelper {

  static const String splashScreen = '/splash';
  static const String languageScreen = '/select-language';
  static const String onBoardingScreen = '/on_boarding';
  static const String welcomeScreen = '/welcome';
  static const String loginScreen = '/login';
  static const String verify = '/verify';
  static const String forgotPassScreen = '/forgot-password';
  static const String createNewPassScreen = '/create-new-password';
  static const String createAccountScreen = '/create-account';
  static const String dashboard = '/';
  static const String maintain = '/maintain';
  static const String update = '/update';
  static const String dashboardScreen = '/main';
  static const String searchScreen = '/search';
  static const String searchResultScreen = '/search-result';
  static const String setMenuScreen = '/set-menu';
  static const String categoryScreen = '/category';
  static const String notificationScreen = '/notification';
  static const String checkoutScreen = '/checkout';
  static const String paymentScreen = '/payment';
  static const String orderSuccessScreen = '/order-completed';
  static const String orderDetailsScreen = '/order-details';
  static const String rateScreen = '/rate-review';
  static const String orderTrackingScreen = '/order-tracking';
  static const String profileScreen = '/profile';
  static const String addressScreen = '/address';
  static const String mapScreen = '/map';
  static const String addAddressScreen = '/add-address';
  static const String selectLocationScreen = '/select-location';
  static const String chatScreen = '/messages';
  static const String couponScreen = '/coupons';
  static const String supportScreen = '/support';
  static const String termsScreen = '/terms';
  static const String policyScreen = '/privacy-policy';
  static const String aboutUsScreen = '/about-us';
  static const String imageDialog = '/image-dialog';
  static const String menuScreenWeb = '/menu_screen_web';
  static const String homeScreen = '/home';
  static const String orderWebPayment = '/order-web-payment';
  static const String popularItemRoute = '/POPULAR_ITEM_ROUTE';
  static const String returnPolicyScreen = '/return-policy';
  static const String refundPolicyScreen = '/refund-policy';
  static const String cancellationPolicyScreen = '/cancellation-policy';
  static const String wallet = '/wallet-screen';
  static const String referAndEarn = '/refer_and_earn';
  static const String branchListScreen = '/branch-list';
  static const String productImageScreen = '/image-screen';
  static const String qrCategoryScreen = '/qr-category-screen';
  static const String loyaltyScreen = '/loyalty-screen';
  static const String orderSearchScreen = '/order-search';



  static String getSplashRoute({RouteAction? action}) => _navigateRoute(splashScreen, route: action);
  static String getLanguageRoute(bool isFromMenu, {RouteAction? action}) => _navigateRoute('$languageScreen?page=${isFromMenu ? 'menu' : 'splash'}', route: action);
  static String getOnBoardingRoute({RouteAction? action}) => _navigateRoute(onBoardingScreen, route: action);
  static String getWelcomeRoute() => _navigateRoute(welcomeScreen, route: RouteAction.pushReplacement);
  static String getLoginRoute({RouteAction? action}) => _navigateRoute(loginScreen, route: action);
  static String getForgetPassRoute() => _navigateRoute(forgotPassScreen);
  static String getNewPassRoute(String emailOrPhone, String token) => _navigateRoute('$createNewPassScreen?email_or_phone=${Uri.encodeComponent(emailOrPhone)}&token=$token');
  static String getVerifyRoute(String page, String email,  {String? session, RouteAction? action}) {
    String data = Uri.encodeComponent(jsonEncode(email));
    String authSession = base64Url.encode(utf8.encode(session ?? ''));
    return _navigateRoute('$verify?page=$page&email=$data&data=$authSession', route: action);
  }

  static String getCreateAccountRoute()=> _navigateRoute(createAccountScreen);
  static String getMainRoute({RouteAction? action}) => _navigateRoute(homeScreen, route: action);
  static String getMaintainRoute({RouteAction? action}) => _navigateRoute(maintain, route: RouteAction.pushReplacement);
  static String getUpdateRoute({RouteAction? action}) => _navigateRoute(update, route: action);
  static String getHomeRoute({required String fromAppBar})=> _navigateRoute('$homeScreen?from=$fromAppBar');
  static String getDashboardRoute(String page, {RouteAction? action}) => _navigateRoute('$dashboardScreen?page=$page', route: action);
  static String getSearchRoute() => _navigateRoute(searchScreen);
  static String getSearchResultRoute(String text) {
    return _navigateRoute('$searchResultScreen?text=${Uri.encodeComponent(jsonEncode(text))}');
  }
  static String getSetMenuRoute() => _navigateRoute(setMenuScreen);
  static String getNotificationRoute() => _navigateRoute(notificationScreen);
  static String getCheckoutRoute(double? amount, String page, String? type, String? code) {
    String amount0= base64Url.encode(utf8.encode(amount.toString()));
    return _navigateRoute('$checkoutScreen?amount=$amount0&page=$page&type=$type&code=$code');
  }

  static String getPaymentRoute(String url, {bool fromCheckout = true}) {
    return _navigateRoute('$paymentScreen?url=${Uri.encodeComponent(url)}&from_checkout=$fromCheckout');
  }
  static String getOrderDetailsRoute(String? id, {String? phoneNumber}) => _navigateRoute('$orderDetailsScreen?id=$id&phone=${Uri.encodeComponent('$phoneNumber')}');
  static String getRateReviewRoute({required orderId, String? phoneNumber}) => _navigateRoute('$rateScreen?id=$orderId&phone=${Uri.encodeComponent('$phoneNumber')}');
  static String getOrderTrackingRoute(int? id, {String? phoneNumber}) => _navigateRoute('$orderTrackingScreen?id=$id&phone=${Uri.encodeComponent('$phoneNumber')}');
  static String getProfileRoute() => _navigateRoute(profileScreen);
  static String getAddressRoute() => _navigateRoute(addressScreen);


  static String getSelectLocationRoute() => _navigateRoute(selectLocationScreen);

  static String getCouponRoute() => _navigateRoute(couponScreen);
  static String getSupportRoute() => _navigateRoute(supportScreen);
  static String getTermsRoute() => _navigateRoute(termsScreen);
  static String getPolicyRoute() => _navigateRoute(policyScreen);
  static String getAboutUsRoute() => _navigateRoute(aboutUsScreen);
  static String getPopularItemScreen() => _navigateRoute(popularItemRoute);
  static String getReturnPolicyRoute() => _navigateRoute(returnPolicyScreen);
  static String getCancellationPolicyRoute() => _navigateRoute(cancellationPolicyScreen);
  static String getRefundPolicyRoute() => _navigateRoute(refundPolicyScreen);
  static String getWalletRoute(bool fromWallet, {String? token, String? flag, RouteAction? action}) => _navigateRoute('$wallet?page=${fromWallet ? 'wallet' : 'loyalty_points'}&&token=$token&&flag=$flag', route: action);
  static String getReferAndEarnRoute() => _navigateRoute(referAndEarn);
  static String getBranchListScreen({RouteAction action = RouteAction.push}) => _navigateRoute(branchListScreen, route: action);
  static String getProductImageScreen(Product product)  {
    String productJson = base64Encode(utf8.encode(jsonEncode(product)));
    return _navigateRoute('$productImageScreen?product=$productJson');
  }
  static getQrCategoryScreen({String? qrData}) => _navigateRoute('$qrCategoryScreen?qrcode=$qrData');
  static String getLoyaltyScreen() => _navigateRoute(loyaltyScreen);
  static String getOrderSearchScreen() => _navigateRoute(orderSearchScreen);
  static String getOrderSuccessScreen(String orderId, String statusMessage) => _navigateRoute('$orderSuccessScreen?order_id=$orderId&status=$statusMessage', route: RouteAction.pushReplacement);

  static String _navigateRoute( String path,{ RouteAction? route = RouteAction.push}) {
    if(route == RouteAction.pushNamedAndRemoveUntil){
      Get.context?.go(path);
    }else if(route == RouteAction.pushReplacement){
      Get.context?.pushReplacement(path);
    }else{
      Get.context?.push(path);
    }
    return path;
  }




  static  Widget _routeHandler(BuildContext context, Widget route, {bool isBranchCheck = false}) {
   return  route;

  }

  static final goRoutes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: ResponsiveHelper.isMobilePhone() ? getSplashRoute() : getMainRoute(),
    routes: [
      GoRoute(path: splashScreen, builder: (context, state) => const SplashScreen()),
      GoRoute(path: languageScreen, builder: (context, state) => ChooseLanguageScreen(fromMenu: state.uri.queryParameters['page'] == 'menu')),
      GoRoute(path: onBoardingScreen, builder: (context, state) => OnBoardingScreen()),
      GoRoute(path: welcomeScreen, builder: (context, state) => _routeHandler(context, const WelcomeScreen())),

      GoRoute(path: homeScreen, builder: (context, state) => _routeHandler(context, const HomeScreen(true))),


      /// I add this line to go my homescreen page


    ],
  );
}