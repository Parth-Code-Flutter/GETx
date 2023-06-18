import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/controller_binding.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/login_as_buyer/view/login_as_buyer_screen.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/otp_buyer/view/otp_verification_buyer.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/registration_as_buyer/view/registration_as_buyer_screen.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/view/login_as_seller_screen.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/otp_seller/view/otp_verification_seller_screen.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/regsitration_as_seller/view/registration_as_seller_screen.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/view/bottom_nav_screen.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/view/b_my_cart_screen.dart';
import 'package:tsofie/app/screens/buyer/cart/order_summary/view/b_order_summary_screen.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/base/view/b_shipping_details_screen.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/view/shipping_addresses_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/all_category_listing/view/b_all_category_listing.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/category_product_listing_screen/view/b_category_product_listing_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/view/b_edit_profile_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/favourite/view/b_fav_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/select_language/view/b_select_language_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/order_details/view/b_order_details_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/view/b_product_details_screen.dart';
import 'package:tsofie/app/screens/buyer/location/add_location/view/b_add_location_screen.dart';
import 'package:tsofie/app/screens/buyer/location/base/view/b_base_location_screen.dart';
import 'package:tsofie/app/screens/buyer/location/search_location/view/b_search_location_screen.dart';
import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/view/s_recent_buyers_list.dart';
import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/view/s_recent_buyers_details.dart';
import 'package:tsofie/app/screens/seller/dashboard/category/all_category_listing/view/s_all_category_listing.dart';
import 'package:tsofie/app/screens/seller/dashboard/category/category_product_listing_screen/view/s_category_product_listing_screen.dart';
import 'package:tsofie/app/screens/seller/dashboard/more/base/view/s_more_base_screen.dart';
import 'package:tsofie/app/screens/seller/dashboard/more/edit_profile/view/s_edit_profile_screen.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/base/view/s_order_list_view.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/edit_product/view/s_edit_product_view.dart';
import 'package:tsofie/app/splash/select_role_screen.dart';
import 'package:tsofie/app/splash/splash_screen.dart';

import 'app/screens/seller/dashboard/order/order_details/view/s_order_details_screen.dart';
import 'app/screens/seller/dashboard/product/add_product/view/add_product_view.dart';
import 'app/screens/seller/dashboard/product/product_details/view/s_product_details_screen.dart';
import 'app/screens/seller/s_bootom_nav_screen/view/s_bottom_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void newMethod({int? a}) {}

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      //theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreens(),
      initialBinding: ControllerBindings(),
      routingCallback: (value) {
        AppConstants().currentRoute = value?.current ?? '';
        debugPrint(' ############# routing callback : ${value?.current}');
      },
      getPages: [
        GetPage(
          name: kRouteSelectRoleScreen,
          page: () => SelectRoleScreen(),
        ),

        /// buyers routes
        GetPage(
          name: kRouteLoginAsBuyerScreen,
          page: () => LoginAsBuyerScreen(),
        ),
        GetPage(
          name: kRouteOtpVerificationBuyerScreen,
          page: () => OtpVerificationBuyerScreen(),
        ),
        GetPage(
          name: kRouteBuyerBottomNavScreen,
          page: () => BuyerBottomNavScreen(),
        ),
        GetPage(
          name: kRouteBBaseLocationScreen,
          page: () => BBaseLocationScreen(),
        ),
        GetPage(
          name: kRouteRegistrationAsBuyerScreen,
          page: () => RegistrationAsBuyerScreen(),
        ),
        GetPage(
          name: kRouteBAddLocationScreen,
          page: () => BAddLocationScreen(),
        ),
        GetPage(
          name: kRouteBSearchLocationScreen,
          page: () => BSearchLocationScreen(),
        ),
        GetPage(
          name: kRouteBProductDetailsScreen,
          page: () => BProductDetailsScreen(),
        ),
        GetPage(
          name: kRouteBOrderDetailsScreen,
          page: () => BOrderDetailsScreen(),
        ),
        GetPage(
          name: kRouteBAllCategoryListing,
          page: () => BAllCategoryListing(),
        ),
        GetPage(
          name: kRouteBMyCartScreen,
          page: () => BMyCartScreen(),
        ),
        GetPage(
          name: kRouteBShippingDetailsScreen,
          page: () => BShippingDetailsScreen(),
        ),
        GetPage(
          name: kRouteBShippingAddressesScreen,
          page: () => BShippingAddressesScreen(),
        ),
        GetPage(
          name: kRouteBOrderSummaryScreen,
          page: () => BOrderSummaryScreen(),
        ),
        GetPage(
          name: kRouteBEditProfileScreen,
          page: () => BEditProfileScreen(),
        ),
        GetPage(
          name: kRouteBCategoryProductListingScreen,
          page: () => BCategoryProductListingScreen(),
        ),
        GetPage(
          name: kRouteBSelectLanguageScreen,
          page: () => BSelectLanguageScreen(),
        ),
        GetPage(
          name: kRouteBFavScreen,
          page: () => BFavScreen(),
        ),

        /// Seller routes
        GetPage(
          name: kRouteLoginAsSellerScreen,
          page: () => LoginAsSellerScreen(),
        ),
        GetPage(
          name: kRouteOtpVerificationSellerScreen,
          page: () => OtpVerificationSellerScreen(),
        ),
        GetPage(
          name: kRouteRegistrationAsSellerScreen,
          page: () => RegistrationAsSellerScreen(),
        ),
        GetPage(
          name: kRouteSellerBottomNavScreen,
          page: () => SellerBottomNavScreen(),
        ),
        GetPage(
          name: kRouteSProductDetailsScreen,
          page: () => SProductDetailsScreen(),
        ),
        GetPage(
          name: kRouteSAddProductScreen,
          page: () => SAddProductBaseScreen(),
        ),
        GetPage(
          name: kRouteSEditProductScreen,
          page: () => SEditProductScreen(),
        ),
        GetPage(
          name: kRouteSOrderBaseScreen,
          page: () => SOrderBaseScreen(),
        ),
        GetPage(
          name: kRouteSOrderDetailsScreen,
          page: () => SOrderDetailsScreen(),
        ),
        GetPage(
          name: kRouteSMoreBaseScreen,
          page: () => SMoreBaseScreen(),
        ),
        GetPage(
          name: kRouteSEditProfileScreen,
          page: () => SEditProfileScreen(),
        ),
        GetPage(
          name: kRouteSRecentBuyersListScreen,
          page: () => SRecentBuyersListScreen(),
        ),
        GetPage(
          name: kRouteSRecentBuyersDetailsScreen,
          page: () => SBuyersDetailsScreen(),
        ),
        GetPage(
          name: kRouteSAllCategoryListing,
          page: () => SAllCategoryListing(),
        ),
        GetPage(
          name: kRouteSCategoryProductListingScreen,
          page: () => SCategoryProductListingScreen(),
        ),
      ],
      // home:,
    );
  }
}
