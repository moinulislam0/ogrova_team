class ApiEndpoints {
  static const String baseUrl =
      "https://backend.mercuviax.com/";
  static const String register = 'api/auth/register';
   static const String login = 'api/auth/login';
   static const String findAccount = 'api/auth/find-account';
   static const String resetOtp = 'api/auth/verify-otp';
   static const String resetPass = 'api/auth/reset-password';
   static const String logout = 'api/auth/logout';
   //products
   static const String publicProducts = 'api/public/products';
   static const String addressCreate = 'api/customer/addresses/create';
   static const String divisions = 'api/public/get-division';
   static const String districts = 'api/public/get-district';
   static const String upazilas = 'api/public/get-upazila';
   static const String policeStations = 'api/public/get-police-station';
   static String productsDetails(String slug) =>
       'api/public/product/$slug';
   static const String addToCart = 'api/cart/add-to-cart';
   static const String  shoppingCart= 'api/cart';
   static const String  billingAddress = 'api/customer/addresses/get';
   static const String couponCheck = 'api/coupon/check';
   static String updateCartQuantity(String reg, int productId, int variantId) =>
       'api/cart/qty-update/$reg/$productId/$variantId';
   static String deleteCart(int cartId, String reg, int productId, int variantId) =>
       'api/cart/remove-to-cart/$cartId/$reg/$productId/$variantId';

  
}
