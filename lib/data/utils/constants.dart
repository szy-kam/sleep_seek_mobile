class Constants {
  static const String baseUrl = 'https://$baseUrlNoPrefix';
  static const String signUpRoute = '$baseUrl/signup';
  static const String loginRoute = '$baseUrl/login';
  static const String currentUserRoute = '$baseUrl/currentUser';
  static const String stayRoute = '$baseUrl/stays';
  static const String stayCategoriesRoute = '$baseUrl/stayCategories';
  static const String stayPropertiesRoute = '$baseUrl/stayProperties';
  static const String accommodationPropertiesRoute =
      '$baseUrl/accommodationProperties';
  static const String accommodationRoute = '$baseUrl/accommodation';
  static const String reservationRoute = '$baseUrl/reservation';
  static const String reviewRoute = '$baseUrl/review';
  static const String imageRoute = '$baseUrl/image';
  static const String stayPath = '/stays';
  static const String reviewPath = '/review';
  static const String accommodationTemplatePath = '/accommodation-template';
  static const String reservationPath = '/reservation';

  static const String baseUrlNoPrefix = 'sleepseek-backend.herokuapp.com';

  static const String tokenKey = 'authentication_token';
  static const String userKey = 'user_key';
  static const String isAuthenticatedKey = 'isUserAuthenticated';

}
