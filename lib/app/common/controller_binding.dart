import 'package:get/get.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/login_as_buyer/controller/login_as_buyer_controller.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/otp_buyer/controller/otp_verification_controller_buyer.dart';
import 'package:tsofie/app/screens/authentication/buyer_auth/registration_as_buyer/controller/registration_as_buyer_controller.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/login_as_seller/controller/login_as_seller_controller.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/otp_seller/controller/otp_vetification_seller_controller.dart';
import 'package:tsofie/app/screens/authentication/seller_auth/regsitration_as_seller/controller/registration_as_seller_controller.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/controller/b_my_cart_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/order_summary/controller/b_order_summary_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/base/controller/b_shipping_details_controller.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/controller/shipping_addresses_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/all_category_listing/controller/b_all_category_listing_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/category_product_listing_screen/controller/b_category_product_listing_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/home/controller/b_home_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/base/controller/b_more_base_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/controller/b_edit_profile_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/favourite/controller/b_fav_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/select_language/controller/b_select_language_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/controller/b_order_base_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/order_details/controller/b_order_details_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/controller/b_product_base_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/controller/b_product_details_controller.dart';
import 'package:tsofie/app/screens/buyer/location/add_location/controller/b_add_location_controller.dart';
import 'package:tsofie/app/screens/buyer/location/base/controller/b_base_location_controller.dart';
import 'package:tsofie/app/screens/buyer/location/search_location/controller/b_search_location_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/controller/s_recent_buyers_details_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/controller/s_recent_buyers_list_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/category/all_category_listing/controller/s_all_category_listing_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/category/category_product_listing_screen/controller/s_category_product_listing_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/more/base/controller/s_more_base_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/more/edit_profile/controller/s_edit_profile_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/base/controller/s_order_list_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/add_product/controller/add_product_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/edit_product/controller/s_edit_product_controller.dart';
import '../screens/seller/dashboard/home/controller/s_home_controller.dart';
import '../screens/seller/dashboard/order/base/view/s_order_list_view.dart';
import '../screens/seller/dashboard/order/order_details/controller/s_order_details_controller.dart';
import '../screens/seller/dashboard/product/base/controller/s_product_base_controller.dart';
import '../screens/seller/dashboard/product/product_details/controller/s_product_details_controller.dart';
import '../screens/seller/s_bootom_nav_screen/controller/s_bottom_nav_controller.dart';
import '../utils/alert_message_utils.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    /// buyer controllers
    Get.lazyPut<LoginAsBuyerController>(
      () => LoginAsBuyerController(),
      fenix: true,
    );
    Get.lazyPut<OtpVerificationControllerBuyer>(
      () => OtpVerificationControllerBuyer(),
      fenix: true,
    );
    Get.lazyPut<RegistrationASBuyerController>(
        () => RegistrationASBuyerController(),
        fenix: true,
    );

    Get.lazyPut<BuyerBottomNavController>(
      () => BuyerBottomNavController(),
      fenix: true,
    );
    Get.lazyPut<BHomeController>(
      () => BHomeController(),
      fenix: true,
    );
    Get.lazyPut<BBaseLocationController>(
      () => BBaseLocationController(),
      fenix: true,
    );
    Get.lazyPut<BAddLocationController>(
      () => BAddLocationController(),
      fenix: true,
    );
    Get.lazyPut<BSearchLocationController>(
      () => BSearchLocationController(),
      fenix: true,
    );
    Get.lazyPut<BProductBaseController>(
      () => BProductBaseController(),
      fenix: true,
    );
    Get.lazyPut<BProductDetailsController>(
      () => BProductDetailsController(),
      fenix: true,
    );
    Get.lazyPut<BOrderBaseController>(
      () => BOrderBaseController(),
      fenix: true,
    );
    Get.lazyPut<BOrderDetailsController>(
      () => BOrderDetailsController(),
      fenix: true,
    );
    Get.lazyPut<BMoreBaseController>(
      () => BMoreBaseController(),
      fenix: true,
    );
    Get.lazyPut<BAllCategoryListingController>(
      () => BAllCategoryListingController(),
      fenix: true,
    );
    Get.lazyPut<BMyCartController>(
      () => BMyCartController(),
      fenix: true,
    );
    Get.lazyPut<BShippingDetailsController>(
      () => BShippingDetailsController(),
      fenix: true,
    );
    Get.lazyPut<BShippingAddressesController>(
      () => BShippingAddressesController(),
      fenix: true,
    );
    Get.lazyPut<BOrderSummaryController>(
      () => BOrderSummaryController(),
      fenix: true,
    );
    Get.lazyPut<BEditProfileController>(
      () => BEditProfileController(),
      fenix: true,
    );
    Get.lazyPut<BCategoryProductListingController>(
      () => BCategoryProductListingController(),
      fenix: true,
    );
    Get.lazyPut<BSelectLanguageController>(
      () => BSelectLanguageController(),
      fenix: true,
    );
    Get.lazyPut<BFavController>(
      () => BFavController(),
      fenix: true,
    );

    /// seller controllers
    Get.lazyPut<LoginAsSellerController>(
      () => LoginAsSellerController(),
      fenix: true,
    );
    Get.lazyPut<OtpVerificationSellerController>(
      () => OtpVerificationSellerController(),
      fenix: true,
    );
    Get.lazyPut<RegistrationAsSellerController>(
      () => RegistrationAsSellerController(),
      fenix: true,
    );
    Get.lazyPut<SHomeController>(
          () => SHomeController(),
      fenix: true,
    );
    Get.lazyPut<SellerBottomNavController>(
          () => SellerBottomNavController(),
      fenix: true,
    );
    Get.lazyPut<SProductBaseController>(
          () => SProductBaseController(),
      fenix: true,
    );
    Get.lazyPut<SProductDetailsController>(
          () => SProductDetailsController(),
      fenix: true,
    );
    Get.lazyPut<SAddProductBaseController>(
        ()=>SAddProductBaseController(),
      fenix: true,
    );
    Get.lazyPut<SEditProductController>(
          ()=>SEditProductController(),
      fenix: true,
    );
    Get.lazyPut<SOrderBaseController>(
          ()=>SOrderBaseController(),
      fenix: true,
    );
    Get.lazyPut<SOrderDetailsController>(
          ()=>SOrderDetailsController(),
      fenix: true,
    );
    Get.lazyPut<SMoreBaseController>(
          ()=>SMoreBaseController(),
      fenix: true,
    );
    Get.lazyPut<SEditProfileController>(
          ()=>SEditProfileController(),
      fenix: true,
    );
    Get.lazyPut<SRecentBuyersListController>(
          ()=>SRecentBuyersListController(),
      fenix: true,
    );
    Get.lazyPut<SBuyersDetailsController>(
          ()=>SBuyersDetailsController(),
      fenix: true,
    );
    Get.lazyPut<SAllCategoryListingController>(
      () => SAllCategoryListingController(),
      fenix: true,
    );
    Get.lazyPut<SCategoryProductListingController>(
      () => SCategoryProductListingController(),
      fenix: true,
    );
    //common controller
    Get.put<AlertMessageUtils>(
      AlertMessageUtils(),
      permanent: true,
    );

  }
}
