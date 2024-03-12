import 'package:atomai/ui/auth/login_option_screen/login_option_screen.dart';
import 'package:atomai/ui/splach_screen/splach_screen.dart';
import 'package:atomai/ui/splach_screen/binding/splach_binding.dart';

import 'package:atomai/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:atomai/ui/auth/forget_password_screen/binding/forget_password_binding.dart';
import 'package:atomai/ui/auth/forget_password_succes_reset_screen/forget_password_succes_reset_screen.dart';
import 'package:atomai/ui/auth/forget_password_succes_reset_screen/binding/forget_password_succes_reset_binding.dart';

import 'package:atomai/ui/auth/agreement_screen/agreement_screen.dart';
import 'package:atomai/ui/auth/agreement_screen/binding/agreement_binding.dart';
import 'package:atomai/ui/auth/boarding_screen/boarding_screen.dart';
import 'package:atomai/ui/auth/boarding_screen/binding/boarding_binding.dart';

import 'package:atomai/ui/generate_note_screen/generate_note_screen.dart';
import 'package:atomai/ui/generate_note_screen/binding/generate_note_binding.dart';

import 'package:atomai/ui/accounts/subscription_screen/subscription_screen.dart';
import 'package:atomai/ui/accounts/subscription_screen/binding/subscription_binding.dart';
import 'package:atomai/ui/accounts/account_screen/account_screen.dart';
import 'package:atomai/ui/accounts/account_screen/binding/account_binding.dart';
import 'package:atomai/ui/edit_note_screen/edit_note_screen.dart';
import 'package:atomai/ui/edit_note_screen/binding/edit_note_binding.dart';
import 'package:atomai/ui/accounts/language_screen/language_screen.dart';
import 'package:atomai/ui/accounts/language_screen/binding/language_binding.dart';

import 'package:atomai/ui/accounts/profile_setting_screen/profile_setting_screen.dart';
import 'package:atomai/ui/accounts/profile_setting_screen/binding/profile_setting_binding.dart';

import 'package:atomai/ui/accounts/change_pass_screen/change_pass_screen.dart';
import 'package:atomai/ui/accounts/change_pass_screen/binding/change_pass_binding.dart';

import 'package:get/get.dart';

import '../ui/auth/login_option_screen/binding/login_option_binding.dart';
import '../ui/auth/login_screen/binding/login_binding.dart';
import '../ui/auth/login_screen/login_screen.dart';
import '../ui/auth/register_option_screen/binding/register_option_binding.dart';
import '../ui/auth/register_option_screen/register_option_screen.dart';
import '../ui/auth/register_screen/binding/register_binding.dart';
import '../ui/auth/register_screen/register_screen.dart';
import '../ui/accounts/premium_page/premium_page.dart';

import '../ui/detail_image_screen/binding/detail_note_binding.dart';
import '../ui/detail_image_screen/detail_image_screen.dart';
import '../ui/generate_image_screen/binding/generate_note_binding.dart';
import '../ui/generate_image_screen/generate_note_screen.dart';
import '../ui/notes_home_page/notes_home_page.dart';

import '../ui/auth/onboarding_screen/binding/onboarding_binding.dart';
import '../ui/auth/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String generateImageScreen = '/generateImageScreen';

  //
  static const String onboardingScreen = '/onboarding_screen';

  static const String splachScreen = '/splach_screen';

  static const String onboarding1Screen = '/onboarding1_screen';

  static const String onboarding2Screen = '/onboarding2_screen';

  static const String onboarding3Screen = '/onboarding3_screen';

  static const String premiumOnePage = '/premium_one_page';

  static const String premiumTwoPage = '/premium_two_page';

  static const String premiumFourPage = '/premium_four_page';

  static const String loginOptionScreen = '/login_option_screen';

  static const String loginScreen = '/login_screen';

  static const String loginErrorScreen = '/login_error_screen';

  static const String forgetPasswordScreen = '/forget_password_screen';

  static const String forgetPasswordCodeVerifScreen =
      '/forget_password_code_verif_screen';

  static const String forgetPasswordSuccesResetScreen =
      '/forget_password_succes_reset_screen';

  static const String registerOptionScreen = '/register_option_screen';

  static const String forgetPasswordErrorScreen =
      '/forget_password_error_screen';

  static const String registerErrorScreen = '/register_error_screen';

  static const String registerScreen = '/register_screen';

  static const String agreementScreen = '/agreement_screen';

  static const String boardingScreen = '/boarding_screen';

  static const String editNotesPage = '/edit_notes_page';

  static const String notesHomePage = '/notes_home_page';

  static const String notesEmptyPage = '/notes_empty_page';

  static const String folderEmptyPage = '/folder_empty_page';

  static const String folderWithContentPage = '/folder_with_content_page';

  static const String editFolderPage = '/edit_folder_page';

  static const String editFolderTabContainerScreen =
      '/edit_folder_tab_container_screen';

  static const String createFolderScreen = '/create_folder_screen';

  static const String generateNoteScreen = '/generate_note_screen';

  static const String passwordNoteScreen = '/password_note_screen';

  static const String premiumFivePage = '/premium_five_page';

  static const String premiumPage = '/premium_page';

  static const String premiumTabContainerScreen =
      '/premium_tab_container_screen';

  static const String premiumThreePage = '/premium_three_page';

  static const String subscriptionScreen = '/subscription_screen';

  static const String accountScreen = '/account_screen';

  static const String researchScreen = '/research_screen';

  static const String editNoteScreen = '/edit_note_screen';

  static const String languageScreen = '/language_screen';

  static const String editScreen = '/edit_screen';

  static const String createSecureNoteScreen = '/create_secure_note_screen';

  static const String profileSettingScreen = '/profile_setting_screen';

  static const String editNameScreen = '/edit_name_screen';

  static const String editEmailScreen = '/edit_email_screen';

  static const String editPhoneScreen = '/edit_phone_screen';

  static const String changePassScreen = '/change_pass_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static String initialRoute = '/initialRoute';
  static const String detailNoteScreen = '/detail_note_screen';

  static List<GetPage> pages = [
    GetPage(
      name: detailNoteScreen,
      page: () => const DetailImageScreen(),
      bindings: [
        DetailNoteBinding(),
      ],
    ),
    GetPage(
      name: generateImageScreen,
      page: () => const GenerateImagesScreen(),
      bindings: [
        GenerateImagesBinding(),
      ],
    ),
    GetPage(
      name: premiumPage,
      page: () => const PremiumPage(),
    ),
    GetPage(
      name: notesHomePage,
      page: () => const NotesHomePage(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
    GetPage(
      name: splachScreen,
      page: () => const SplachScreen(),
      bindings: [
        SplachBinding(),
      ],
    ),
    GetPage(
      name: loginOptionScreen,
      page: () => const LoginOptionScreen(),
      bindings: [
        LoginOptionBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      bindings: [
        ForgetPasswordBinding(),
      ],
    ),
    GetPage(
      name: forgetPasswordSuccesResetScreen,
      page: () => const ForgetPasswordSuccesResetScreen(),
      bindings: [
        ForgetPasswordSuccesResetBinding(),
      ],
    ),
    GetPage(
      name: registerOptionScreen,
      page: () => const RegisterOptionScreen(),
      bindings: [
        RegisterOptionBinding(),
      ],
    ),
    GetPage(
      name: registerScreen,
      page: () => const RegisterScreen(),
      bindings: [
        RegisterBinding(),
      ],
    ),
    GetPage(
      name: agreementScreen,
      page: () => const AgreementScreen(),
      bindings: [
        AgreementBinding(),
      ],
    ),
    GetPage(
      name: boardingScreen,
      page: () => const BoardingScreen(),
      bindings: [
        BoardingBinding(),
      ],
    ),
    GetPage(
      name: generateNoteScreen,
      page: () => const GenerateNoteScreen(),
      bindings: [
        GenerateNoteBinding(),
      ],
    ),
    GetPage(
      name: subscriptionScreen,
      page: () => const SubscriptionScreen(),
      bindings: [
        SubscriptionBinding(),
      ],
    ),
    GetPage(
      name: accountScreen,
      page: () => const AccountScreen(),
      bindings: [
        AccountBinding(),
      ],
    ),
    GetPage(
      name: editNoteScreen,
      page: () => const EditNoteScreen(),
      bindings: [
        EditNoteBinding(),
      ],
    ),
    GetPage(
      name: languageScreen,
      page: () => const LanguageScreen(),
      bindings: [
        LanguageBinding(),
      ],
    ),
    GetPage(
      name: profileSettingScreen,
      page: () => const ProfileSettingScreen(),
      bindings: [
        ProfileSettingBinding(),
      ],
    ),
    GetPage(
      name: changePassScreen,
      page: () => const ChangePassScreen(),
      bindings: [
        ChangePassBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => const SplachScreen(),
      bindings: [
        SplachBinding(),
      ],
    )
  ];
}
