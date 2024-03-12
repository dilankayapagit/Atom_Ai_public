import 'dart:developer';
import 'dart:io';

import 'package:atomai/models/pay_custom_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../models/pay_package_model.dart';

class PaymentController extends GetxController {
  final package = payModelCustom[3].obs;
  final customerInfo = <CustomerInfo>[].obs;
  final packageNew = payCustomModelNew[6].obs;
  final packs = <String>["", "", "", "", "", ""].obs;

  Future<bool> getOfferings() async {
    try {
      final packsTemp = <String>[];
      var offerings = await Purchases.getOfferings();
      final package = offerings.current!.availablePackages;
      for (var pack in package.toList()) {
        packsTemp.add(pack.storeProduct.priceString);
      }
      packs(packsTemp);
    } catch (e) {
      log("getOfferings $e");
    }

    update();
    return true;
  }

  Future<bool> makePurchases(int index) async {
    // if (await getSubscribeStatus()) {
    //   return true;
    // }

    try {
      var offerings = await Purchases.getOfferings();
      final package = offerings.current!.availablePackages;
      // log(package.toString());
      // CustomerInfo customerInfo =
      await Purchases.purchasePackage(package[index]);
      await getSubscribeStatus();
      // log(customerInfo.toJson().toString());
      // var isPro = customerInfo.entitlements.all["atomai_premium"]!.isActive;
      // if (isPro) {}
      return true;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        // Fluttertoast.showToast(
        //     msg: e.toString(),
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        log("message$e");
      }
    } catch (e) {
      log("message$e");
    } finally {
      update();
    }
    return false;
  }

  Future<bool> getSubscribeStatus() async {
    bool isActive = false;
    try {
      CustomerInfo customerInfoTemp = await Purchases.getCustomerInfo();
      customerInfo.add(customerInfoTemp);
      // log(customerInfoTemp.toString());
      // log("*******");

      for (var payCustomModel in payCustomModelNew) {
        if (customerInfoTemp.entitlements.all[payCustomModel.entitleId] !=
                null &&
            customerInfoTemp
                .entitlements.all[payCustomModel.entitleId]!.isActive) {
          packageNew(payCustomModel);
          break;
        }
      }
      //log(packageNew.value.toString());

      if (customerInfoTemp.entitlements.all[payModelCustom[0].offeringId] !=
              null &&
          customerInfoTemp
              .entitlements.all[payModelCustom[0].offeringId]!.isActive) {
        package(payModelCustom[0]);
        return true;
      }
      if (customerInfoTemp.entitlements.all[payModelCustom[1].offeringId] !=
              null &&
          customerInfoTemp
              .entitlements.all[payModelCustom[1].offeringId]!.isActive) {
        package(payModelCustom[1]);
        return true;
      }
      if (customerInfoTemp.entitlements.all[payModelCustom[2].offeringId] !=
              null &&
          customerInfoTemp
              .entitlements.all[payModelCustom[2].offeringId]!.isActive) {
        package(payModelCustom[2]);
        return true;
      }
      package(payModelCustom[3]);
      //log("subscription" + customerInfo[0].toJson().toString());
      //log("subscription ${customerInfoTemp.toString()}");
      //log("subscription ${packageNew.value.payId}");

      //log("subscription ${package.value.offeringId}");
      getOfferings();
    } catch (e) {
      log("message$e");
    }
    return isActive;
  }

  Future<bool> restorePayment() async {
    try {
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      log(restoredInfo.toJson().toString());
      getSubscribeStatus();
      Fluttertoast.showToast(
          msg: "Purchases Restored",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      log("message$e");
    } finally {
      update();
    }
    return false;
  }

  static Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.info);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_OUlRKXLIBwXuVPgeURXhCGCmrfs");
    } else {
      configuration =
          PurchasesConfiguration("appl_sUImyeuZgnpzLRbUigZibCkRiOq");
    }
    await Purchases.configure(configuration);
  }

  @override
  void onReady() {
    super.onReady();
    if (!kIsWeb) {
      initPlatformState();
    }
  }

  static List<PayCustomPay> payCustomModelNew = [
    PayCustomPay(
      maxTxt: 50000,
      payName: "Lite",
      payId: "lite_atomai_m",
      entitleId: "atomai_l_m_e",
      type: "m",
      wordsAnu: 500,
      maxImg: 10,
    ),
    PayCustomPay(
      maxTxt: 500000,
      payName: "Lite",
      payId: "lite_atomai_y",
      entitleId: "atomai_l_y_e",
      type: "y",
      wordsAnu: 500,
      maxImg: 100,
    ),
    PayCustomPay(
      maxTxt: 50000,
      payName: "Pro",
      payId: "pro_atomai_m",
      entitleId: "atomai_p_m_e",
      type: "m",
      wordsAnu: 1000,
      maxImg: 20,
    ),
    PayCustomPay(
      maxTxt: 500000,
      payName: "Pro",
      payId: "pro_atomai_y",
      entitleId: "atomai_p_y_e",
      type: "y",
      wordsAnu: 1000,
      maxImg: 200,
    ),
    PayCustomPay(
      maxTxt: 100000,
      payName: "Advanced",
      payId: Platform.isAndroid ? "advanced_atomai_m" : "atomai_advanced_m_n",
      entitleId: "atomai_a_m_e",
      type: "m",
      wordsAnu: 2000,
      maxImg: 50,
    ),
    PayCustomPay(
      maxTxt: 1000000,
      payName: "Advanced",
      payId: "advanced_atomai_y",
      entitleId: "atomai_a_y_e",
      type: "y",
      wordsAnu: 2000,
      maxImg: 500,
    ),
    PayCustomPay(
      maxTxt: 5000,
      payName: "Free",
      payId: "Free",
      entitleId: "",
      type: "m",
      wordsAnu: 500,
      maxImg: 2,
    ),
  ];

  static List<PayModelCustom> payModelCustom = [
    PayModelCustom(
      monthIndex: 0,
      yearIndex: 1,
      maxTxt: 500000,
      titleText: "lite_titile",
      offeringId: "atomai_lite",
      payName: "Lite",
      payIdMonth: "lite_atomai_m",
      payIdYearly: "lite_atomai_y",
      payYearly: "lite_payYearly",
      monthButtonText: "lite_buttonText",
      paySmallDescription: "Auto_Renewable",
      // paySmallDescription: "lite_paySmallDescription",
      packages: [
        "lite_desc1",
        "lite_desc2",
        "lite_desc3",
        "lite_desc4",
      ],
      description: "lite_description",
    ),
    PayModelCustom(
      monthIndex: 2,
      yearIndex: 3,
      maxTxt: 500000,
      titleText: "pro_titile",
      offeringId: "atomai_pro",
      payName: "Pro",
      payIdMonth: "pro_atomai_m",
      payIdYearly: "pro_atomai_y",
      payYearly: "pro_payYearly",
      monthButtonText: "pro_buttonText",
      paySmallDescription: "Auto_Renewable",
      // paySmallDescription: "pro_paySmallDescription",
      packages: [
        "pro_desc1",
        "pro_desc2",
        "pro_desc3",
        "pro_desc4",
      ],
      description: "pro_description",
    ),
    PayModelCustom(
      titleText: "advanced_titile",
      monthIndex: 4,
      yearIndex: 5,
      maxTxt: 1000000,
      offeringId: "atomai_advanced",
      payName: "Advanced",
      payIdMonth:
          Platform.isAndroid ? "advanced_atomai_m" : "atomai_advanced_m_n",
      payIdYearly: "advanced_atomai_y",
      payYearly: "advanced_payYearly",
      monthButtonText: "advanced_buttonText",
      paySmallDescription: "Auto_Renewable",
      // paySmallDescription: "advanced_paySmallDescription",
      packages: [
        "advanced_desc1",
        "advanced_desc2",
        "advanced_desc3",
        "advanced_desc4",
      ],
      description: "advanced_description",
    ),
    PayModelCustom(
      maxTxt: 5000,
      offeringId: "atomai_free",
      payName: "Free",
      payIdMonth: "",
      payIdYearly: "",
      payYearly: "",
      paySmallDescription: "",
      packages: [],
      description: "",
    ),
  ];
}
