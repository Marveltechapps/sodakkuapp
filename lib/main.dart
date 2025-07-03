import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/presentation/category/categories_screen.dart';
import 'package:sodakkuapp/presentation/coupon/screens/applying_coupon_screen.dart';
import 'package:sodakkuapp/presentation/entry/login/login_screen.dart';
import 'package:sodakkuapp/presentation/entry/splash/splash_screen.dart';
import 'package:sodakkuapp/presentation/home/home_screen.dart';
import 'package:sodakkuapp/presentation/payment/payment_screen.dart';
import 'package:sodakkuapp/presentation/settings/address/address_screen.dart';
import 'package:sodakkuapp/presentation/settings/customer_support/customer_support_screen.dart';
import 'package:sodakkuapp/presentation/settings/general_info/general_policies_screen.dart';
import 'package:sodakkuapp/presentation/settings/general_info/privacy_policy_screen.dart';
import 'package:sodakkuapp/presentation/settings/general_info/terms_conditions_screen.dart';
import 'package:sodakkuapp/presentation/settings/notifications/notifications_screen.dart';
import 'package:sodakkuapp/presentation/settings/order/order_screen.dart';
import 'package:sodakkuapp/presentation/settings/payment_management/payment_management_screen.dart';
import 'package:sodakkuapp/presentation/settings/profile/profile_screen.dart';
import 'package:sodakkuapp/presentation/settings/refunds/refunds_screen.dart';
import 'package:sodakkuapp/presentation/settings/settings_screen.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sodakkuapp/utils/widgets/restart_widget.dart';
import 'presentation/entry/otp/otp_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('💥 Flutter error: ${details.exception}');
    debugPrint('📌 Stack trace: ${details.stack}');
  };
  runApp(
    ShowCaseWidget(
      builder: (context) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Future<void> getProps() async {
     final isExpired = await TokenService.isExpired();
      if(isExpired && await TokenService.getToken() != null){
        await TokenService.deleteToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', '');
        await prefs.setString('userid', '');
        await prefs.setBool('isLoggedIn', false);
        isLoggedInvalue = false;
        phoneNumber = '';
        userId = '';
        RestartWidget.restartApp(context);
      }
  }

  @override
  void initState() {
    super.initState();
    getProps();
  }
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        title: 'Sodakku',
        debugShowCheckedModeBanner: false,
      
        // ✅ Locks text and display scale
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          appBarTheme: AppBarTheme(
            backgroundColor: appColor,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            elevation: 4,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: appColor,
            selectionColor: appColor,
            selectionHandleColor: appColor,
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            labelMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            bodySmall: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Colors.black,
            ),
            displayMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              color: Colors.black,
            ),
            bodyMedium: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontFamily: "Poppins Bold",
              fontSize: 30,
              color: Colors.white,
              height: 1,
              letterSpacing: 0.5,
            ),
          ),
        ),
      
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginScreen(),
          '/otp': (context) => OtpScreen(),
          '/home': (context) => HomeScreen(),
          '/categories': (context) => CategoriesScreen(),
          '/payment': (context) => PaymentScreen(),
          '/ApplyingCouponScreen': (context) => ApplyingCouponScreen(),
          '/settings': (context) => SettingsScreen(),
          '/order': (context) => OrderScreen(),
          '/customerSupport': (context) => CustomerSupportScreen(),
          '/address': (context) => AddressScreen(),
          '/refunds': (context) => RefundsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/generalPolicies': (context) => GeneralPoliciesScreen(),
          '/termsAndConditions': (context) => TermsConditionsScreen(),
          '/privacyPolicy': (context) => PrivacyPolicyScreen(),
          '/notifications': (context) => NotificationsScreen(),
          '/paymentManagementScreen': (context) => PaymentManagementScreen(),
        },
      
        home: SplashScreen(),
      ),
    );
  }
}
