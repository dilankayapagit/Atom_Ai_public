import 'package:atomai/app_export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../main.dart';
import '../../../services/payment_controller.dart';
import '../../../services/user_data_controller.dart';
import '../../accounts/language_screen/controller/language_controller.dart';
import '../../notes_home_page/controller/notes_home_controller.dart';

class SplachController extends GetxController {
  var userDataController = Get.put(UserDataController());
  var languageController = Get.put(LanguageController());
  var notesHomeController = Get.put(NotesHomeController());
  var paymentController = Get.put(PaymentController());

  @override
  void onReady() {
    super.onReady();
    stratup();
  }

  stratup() async {
    // if (kDebugMode) {
    //   Get.offNamed(AppRoutes.generateImageScreen);
    //   // // Get.to(NotesEmptyPage());
    //   return;
    // }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showFlutterNotification(message);
      }
    });
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await userDataController.setFirebaseUser();
      userDataController.getUserData();
      // notesHomeController.getNotes();
      // notesHomeController.getFolder();
      languageController.startup();
      userDataController.setPushToekn();
      // notesHomeController.subscribeToFolders();

      // notesHomeController.getDataFun();
      // paymentController.getSubscribeStatus();
      await Future.delayed(const Duration(milliseconds: 3000), () {});
      Get.offNamed(AppRoutes.notesHomePage);
      return;
    }
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Get.offNamed(AppRoutes.onboardingScreen);
  }
}
