class EndPoints {
  static final String baseUrl="https://seowebdesign.in/feelathome/site/api/v1";

  // image end point
  String APIImages = "https://seowebdesign.in/feelathome/site/images/1/";


  //post
  static final String login ="$baseUrl/login";
  static final String forgot ="$baseUrl/forgot-password";
  static final String submit_enquiry ="$baseUrl/submit-enquiry";
  static final String submit_support_ticket ="$baseUrl/submit-support-ticket";
  static final String post_profile_details="$baseUrl/customer-basic-update";
  static final String post_property_with_search="$baseUrl/property-with-search";
  static final String post_star_rating="$baseUrl/star-rating";
  static final String post_update_notification="$baseUrl/update-notifications-receiving-status";

  //get
  static final String getPropertieslist ="$baseUrl/properties-guest";
  static final String getPropertiesWithSearch ="$baseUrl/property-with-search";
  static final String getRoomsList ="$baseUrl/properties";
  static final String get_profile_details ="$baseUrl/customer-basic";
  static final String get_complaint_list ="$baseUrl/support-tickets";
  static final String get_help_list ="$baseUrl/help";
  static final String get_about_list ="$baseUrl/about";
  static final String get_country_list ="$baseUrl/get-countries";
  static final String get_college_list ="$baseUrl/get-initial-filters";
  static final String get_campus_list ="$baseUrl/getCampusCustom";
  static final String get_notificatons_list ="$baseUrl/notifications";



 //not for feel at home these are samples
  //
  static final String getPhotoOrdersList =
      "${baseUrl}seller-order-list?customer_id=";
  static final String getPhotoOrderDetails =
      "${baseUrl}seller-order-details?seller_order_id=";
  static final String orderChat = "${baseUrl}order-chat";
  static final String getTextMessage = "${baseUrl}list-chats?customer_id=";
  static final String addAddress = "${baseUrl}add-address";
}
