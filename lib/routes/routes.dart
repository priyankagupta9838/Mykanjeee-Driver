import 'package:flutter/material.dart';
import 'package:mykanjeedriver/Authentication/SignUP-1.dart';
import 'package:mykanjeedriver/Authentication/login.dart';
import 'package:mykanjeedriver/profile/profile.dart';
import 'package:mykanjeedriver/routes/routesname.dart';

import '../Authentication/OtpResetScreen.dart';
import '../Authentication/SignUp-2.dart';
import '../Authentication/login with phone number.dart';
import '../Authentication/loginOtpVerification.dart';
import '../Authentication/otpVerification.dart';
import '../Authentication/resetPassword.dart';
import '../Authentication/resetPasswordWithEmail.dart';
import '../navigationbar.dart';
import '../orders/orderdetail.dart';
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
      case RoutesName.loginWithPhoneNumber:
        return MaterialPageRoute(builder: (context) => const LogInPhoneNumber());
      case RoutesName.signUp1:
        return MaterialPageRoute(builder: (context) => const SignUpPage1());
      case RoutesName.signUp2:
        return MaterialPageRoute(builder: (context) => const SignUpPage2(email: '', name: '',));
      case RoutesName.signUpOtp:
        return MaterialPageRoute(builder: (context) =>  OtpVerification(name: '', userName: '', password: '', confirmPassword: '',));
      case RoutesName.resetPasswordWithEmail:
        return MaterialPageRoute(builder: (context) =>  const ResetPasswordWithEmail());
      case RoutesName.resetPasswordWithEmailOtpVerification:
        return MaterialPageRoute(builder: (context) =>   ResetOtpScreen(userName: '',));
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (context) =>  ProvideResetPassword(otp: '', username: '',));
      case RoutesName.resetOtpVerification:
        return MaterialPageRoute(builder: (context) => LoginWithOtpVerification(userName: ""));
      case RoutesName.storageStream:
        return MaterialPageRoute(builder: (context) =>const StorageStream());
      case RoutesName.navigationBar:
        return MaterialPageRoute(builder: (context) =>const Navigation());
      case RoutesName.userProfile:
        return MaterialPageRoute(builder: (context) =>const Profile());
      case RoutesName.setupProfile:
        return MaterialPageRoute(builder: (context) => UserRegistrationProfile(selectedService: '',));
      case RoutesName.documentVerification:
        return MaterialPageRoute(builder: (context) =>const AccountDetails2());
      case RoutesName.detailSaved:
        return MaterialPageRoute(builder: (context) =>const DetailsSaved());
      case RoutesName.setUpAccountDetail:
        return MaterialPageRoute(builder: (context) =>const AccountDetail());
      case RoutesName.orderDetail:
        return MaterialPageRoute(builder: (context) => OrderDetail(data: settings.arguments as Map,));


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
