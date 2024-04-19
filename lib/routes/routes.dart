import 'package:demo_task/modules/%20terms_of_service/terms_of_service_controller.dart';
import 'package:demo_task/modules/auth/login/login.dart';
import 'package:demo_task/modules/auth/login/login_controller.dart';
import 'package:demo_task/modules/auth/otp_verify_screen/otp_verify_screen.dart';
import 'package:demo_task/modules/auth/otp_verify_screen/otp_verify_screen_controller.dart';
import 'package:demo_task/modules/company_select/company_select.dart';
import 'package:demo_task/modules/company_select/company_select_controller.dart';
import 'package:demo_task/modules/contact_us/contact_us.dart';
import 'package:demo_task/modules/contact_us/contact_us_controller.dart';
import 'package:demo_task/modules/home_page/home_page.dart';
import 'package:demo_task/modules/home_page/home_page_controller.dart';
import 'package:demo_task/modules/select_country/select_country.dart';
import 'package:demo_task/modules/select_country/select_country_controller.dart';
import 'package:demo_task/modules/%20terms_of_service/terms_of_service.dart';
import 'package:demo_task/routes/pages.dart';
import 'package:get/get.dart';

abstract class Routes {
  static List<GetPage> pages = [
    GetPage(
      name: Pages.initialRoute,
      page: () => HomePage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => HomePageController())),
    ),
    GetPage(
      name: Pages.termsOfService,
      page: () => TermsOfService(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => TermsOfServiceController())),
    ),
    GetPage(
      name: Pages.selectCountry,
      page: () => SelectCountry(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => SelectCountryController())),
    ),
    GetPage(
      name: Pages.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
    ),
    GetPage(
      name: Pages.otpVerify,
      page: () => OtpVerifyScreen(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => OtpVerifyScreenController())),
    ),
    GetPage(
      name: Pages.companySelect,
      page: () => CompanySelect(),
      binding:
          BindingsBuilder(() => Get.lazyPut(() => CompanySelectController())),
    ),
    GetPage(
      name: Pages.contactUs,
      page: () => ContactUs(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ContactUsController())),
    ),
  ];
}
