class ApiConst {
  static String baseUrl = 'http://tsofie.briskbrain.com/';

//common

  static String login = 'sessions/login';
  static String otp = 'sessions/verify_otp';
  static String reSendOTP = 'sessions/resend_otp';
  static String categoriesList = '/categories';
  static String gstList = '/gst';
  static String bannersImgList = 'banners';
  static String gstNumber = 'gst/validate';

  static String generalApi = 'general_api';

//buyer

  static const String _buyer = 'buyer';
  static const String _cart = 'carts';
  static const String _territories = 'territories';

  static String stateList = '$_territories/state_list';
  static String cityList = '$_territories/city_list';

  static String buyerReg = '$_buyer/registrations';
  static String locationList = '$_buyer/locations';
  static String editProfile = '$_buyer/profile/update';
  static String getBuyerProfile = '$_buyer/get_profile';

  static String productList = '$_buyer/products';
  static String favouriteProductList = '$_buyer/products/favourite_products';
  static String favUnFav = 'favourite_unfavourite';
  static String addToCart = '$_buyer/$_cart/add_to_cart';
  static String cartItemsList = '$_buyer/$_cart';
  static String removeCartItem = '$_buyer/$_cart/remove_cart_item';
  static String checkAvailableQuantity = '$_buyer/products/check_available_quantity';
  static String updateCart = '$_buyer/$_cart/update_cart';

  static String shippingAddressList = '$_buyer/addresses';

  static String createOrder = '$_buyer/place_order';
  static String getOrdersList = '$_buyer/orders';
  static String getRecentOrdersList = '$_buyer/orders/recent_orders';

// Seller

  static const String _seller = 'seller';
  static String sellerReg = '$_seller/registrations';
  static String editProfileSeller = '$_seller/profile/update';
  static String getProfile = '$_seller/get_profile';
  static String productList_seller = '$_seller/products';
  static String addProduct='$_seller/products';
  static String recentProducts='$_seller/products/recent_products';
  static String deleteProduct='$_seller/products';
  static String updateProduct='$_seller/products';
  static String recentBuyers='$_seller/recent_buyers';
  static String recentOrders='$_seller/recent_orders';

}
