import 'package:flutter/material.dart';
import 'package:mykanjeedriver/Authentication/SignUP-1.dart';
import 'package:mykanjeedriver/Authentication/login.dart';
import 'package:mykanjeedriver/profile/profile.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import '../Authentication/OtpResetScreen.dart';
import '../Authentication/SignUp-2.dart';
import '../Authentication/loginwithotp.dart';
import '../Authentication/loginOtpVerification.dart';
import '../Authentication/signUpOtpVerification.dart';
import '../Authentication/resetPassword.dart';
import '../Authentication/forgotPassword.dart';
import '../navigationbar.dart';
import '../orders/productorder/assignedorderdetail.dart';
import '../orders/productorder/deliveredoderdetail.dart';
import '../orders/productorder/orderdetail.dart';
import '../orders/productorder/rejecteddetailOrder.dart';
import '../orders/serviceorder/AssignedServiceOrderDetail.dart';
import '../orders/serviceorder/acceptedServiceDetail.dart';
import '../orders/serviceorder/deliveredServiceorderDetail.dart';
import '../orders/serviceorder/dropofforderdetail.dart';
import '../orders/serviceorder/pickuporderdetail.dart';
import '../orders/serviceorder/rejectedserviceorderdetail.dart';
import '../profile/aacountsetting.dart';
import '../profile/editprofile.dart';
import '../registration/accountdetail.dart';
import '../registration/detailsavedpage.dart';
import '../registration/docqumentverification.dart';
import '../registration/setupyourprofile.dart';
import '../screens/splashScreen.dart';
import '../storagestreame.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LogInPage());
      case RoutesName.loginWithOtp:
        return MaterialPageRoute(builder: (context) => const LogInWithOtp());
      case RoutesName.loginWithOtpVerification:
        return MaterialPageRoute(builder: (context) => LoginWithOtpVerification(userName: settings.arguments as String,));
      case RoutesName.signUp1:
        return MaterialPageRoute(builder: (context) => const SignUpPage1());
      case RoutesName.signUp2:
        return MaterialPageRoute(builder: (context) =>  SignUpPage2(data: settings.arguments as Map,));
      case RoutesName.signUpOtp:
        return MaterialPageRoute(builder: (context) =>  SignUpOtpVerification(data:settings.arguments as Map,));
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (context) =>  const ForgotPassword());
      case RoutesName.forgotPasswordOtp:
        return MaterialPageRoute(builder: (context) =>   ResetOtpScreen(userName:settings.arguments as String,));
      case RoutesName.forgotPasswordOtpVerification:
        return MaterialPageRoute(builder: (context) =>  ProvideResetPassword(data:  settings.arguments as Map,));
      case RoutesName.storageStream:
        return MaterialPageRoute(builder: (context) =>const StorageStream());
      case RoutesName.navigationBar:
        return MaterialPageRoute(builder: (context) =>const Navigation());
      case RoutesName.userProfile:
        return MaterialPageRoute(builder: (context) =>const Profile());
      case RoutesName.updateUserProfile:
        return MaterialPageRoute(builder: (context) =>const UerProfile());
      case RoutesName.accountSetting:
        return MaterialPageRoute(builder: (context) =>const AccountsSetting());
      case RoutesName.setupProfile:
        return MaterialPageRoute(builder: (context) => UserRegistrationProfile());
      case RoutesName.documentVerification:
        return MaterialPageRoute(builder: (context) =>const AccountDetails2());
      case RoutesName.detailSaved:
        return MaterialPageRoute(builder: (context) =>const DetailsSaved());
      case RoutesName.setUpAccountDetail:
        return MaterialPageRoute(builder: (context) =>const AccountDetail());
      case RoutesName.acceptedOrderDetail:
        return MaterialPageRoute(builder: (context) => OrderDetail(data: settings.arguments as Map,));
      case RoutesName.assignedServiceOrderDetail:
        return MaterialPageRoute(builder: (context) => AssignedServiceOrderDetail(data: settings.arguments as Map,));
      case RoutesName.assignedOrderDetail:
        return MaterialPageRoute(builder: (context) => AssignedOrderDetail(data: settings.arguments as Map,));
      case RoutesName.rejectedOderDetail:
        return MaterialPageRoute(builder: (context) => RejectedOrderDetail(data: settings.arguments as Map,));
      case RoutesName.deliveredOderDetail:
        return MaterialPageRoute(builder: (context) => DeliveredOrderDetail(data: settings.arguments as Map,));
      // case RoutesName.acceptedServiceOderDetail:
      //   return MaterialPageRoute(builder: (context) => AcceptedServiceOrderDetail(data: settings.arguments as Map,));
      case RoutesName.deliveredServiceOderDetail:
        return MaterialPageRoute(builder: (context) => DeliveredServiceOrderDetail(data: settings.arguments as Map,));
      case RoutesName.rejectedServiceOderDetail:
        return MaterialPageRoute(builder: (context) => RejectedServiceOrderDetail(data: settings.arguments as Map,));
      case RoutesName.pickUpOderDetail:
        return MaterialPageRoute(builder: (context) => PickUpOrderDetail(data: settings.arguments as Map,));
      case RoutesName.dropOffOderDetail:
        return MaterialPageRoute(builder: (context) => DropOffOrderDetail(data: settings.arguments as Map,));















      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
    }
  }
}
