class ApiList{

  static const baseUrl="http://103.174.102.241:3030";
  //static const baseUrl="http://103.174.103.122:3838";
  static const registerNewDriver="/api/delivery-person/register-as-delivery-person-with-otp";
  static const registerNewDriverVerifyOtp="/api/delivery-person/register-as-delivery-person-verify-otp";
  static const updateDriverDetails="/api/delivery-person/register-as-delivery-person";
  static const updateAccountDetails="/api/delivery-person/add-account-details";
  static const login="/api/delivery-person/login";
  static const loginWithOtp="/api/delivery-person/login-send-otp";
  static const loginWithOtpVerification="/api/delivery-person/login-otp-verify";
  static const forgotPassword="/api/delivery-person/forgot-password";
  static const newPassword="/api/delivery-person/new-password";

  static const getUser="/api/auth/get-user";
  static const rejectOrderByDriver="/api/delivery-person/reject-assigned-order";
  static const rejectOrderByCustomer="/api/delivery-person/order-rejected-by-customer";
  static const acceptOrderByDriver="/api/delivery-person/accept-assigned-order";
  static const allAssignedOrder="/api/delivery-person/all-assigned-order";
  static const deliveredOrder="/api/delivery-person/delivered-order";
  static const collectOrder="/api/delivery-person/collected-order";
  static const activeUser="/api/delivery-person/active_inactive";
  static const orders="/api/delivery-person/order";
  static const updateLocation="/api/delivery-person/update-current-location";
  static const assignOrderToDiver="/api/delivery-person/assign-order-to-delivery-person";
  static const uploadProfile="/api/delivery-person/driver-upload-profile-picture";
  static const deleteAccount="/api/delivery-person/delete-account-request";

}