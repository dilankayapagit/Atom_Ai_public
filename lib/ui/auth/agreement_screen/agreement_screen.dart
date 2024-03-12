import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';
import 'package:atomai/app_export.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  ScrollController scrollController = ScrollController();
  final List<String> list = [
    "The right to be informed.",
    "The right of access.",
    "The right to rectification.",
    "The right to erasure.",
    "The right to restrict processing.",
    "The right to data portability.",
    "The right to object.",
    "Rights related to automated decision-making and profiling.",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.85,
                  child: ListView(
                    controller: scrollController,
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: getPadding(
                            left: 10,
                            top: 20,
                          ),
                          child: Text(
                            "Privacy Policy".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium18.copyWith(
                              letterSpacing: getHorizontalSize(
                                0.56,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 25,
                          top: 15,
                          right: 25,
                        ),
                        child: Text(
                          "The Atom AI mobile application is owned by Atom AI, which is a data controller of your personal data.\n We have adopted this privacy policy, which sets out the way we process the information collected by Atom AI and also provides the reasons why we need to collect certain personal data about you. Therefore, you should read this privacy policy before using the Atom AI mobile application.\nWe take care of your personal data and are committed to ensuring its confidentiality and security.\n Personal information we collect: When you visit the Atom AI mobile application, we automatically collect certain information about your device, including information about your web browser, IP address, time zone, and some of the cookies installed on your device. Additionally, as you browse the application, we collect information about the web pages or individual products that you view, the websites or search terms that referred you to the application, and how you interact with the application. We refer to this automatically collected information as “Device Information”. Furthermore, we may collect personal data that you provide to us (including but not limited to name, address, payment information, etc.) when registering in order to execute the contract.\n Why do we process your data? Our top priority is the security of customer data and, as such, we can only process minimal data on users, only to the extent that it is absolutely necessary to maintain the application. The automatically collected information is used only to identify potential cases of abuse and establish statistical information regarding the use of the Atom AI mobile application. This statistical information is not otherwise aggregated in such a way as to identify any particular user of the system.\n You can visit the application without telling us who you are or revealing any information by which someone could identify you as a specific, identifiable individual. However, if you want to use certain features of the Atom AI mobile application, or if you want to receive our newsletter or provide other details by filling out a form, you may provide us with personal data such as your email, first name, last name, city of residence, organization, phone number. You may choose not to provide us with your personal data, but you may then not be able to take advantage of certain features of the application. For example, you will not be able to receive our newsletter or contact us directly from the application. Users who do not know which information is required are invited to contact us via support@atomai.fr.\n Your rights: If you are a European resident, you have the following rights in relation to your personal data:",
                          maxLines: 100,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsRegular12.copyWith(
                            letterSpacing: getHorizontalSize(
                              0.30,
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: getPadding(
                              top: 20,
                              left: 25,
                              right: 25,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: getSize(
                                    8.00,
                                  ),
                                  width: getSize(
                                    8.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.indigo400,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        4.00,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: getHorizontalSize(
                                    268.00,
                                  ),
                                  margin: getMargin(
                                    left: 16,
                                  ),
                                  child: Text(
                                    list[index].tr,
                                    maxLines: null,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12WhiteA700
                                        .copyWith(
                                      letterSpacing: getHorizontalSize(
                                        0.30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: getPadding(
                          top: 20,
                          left: 25,
                          right: 25,
                        ),
                        child: Container(
                          width: getHorizontalSize(
                            302.00,
                          ),
                          margin: getMargin(
                            top: 24,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '''
          If you wish to exercise this right, please contact us via the contact details below.
          
          In addition, if you are a European resident, we note that we are processing your information in order to fulfill contracts we might have with you (for example, if you make an order through the Atom AI mobile application), or otherwise to pursue our legitimate business interests listed above. Also, please note that your information might be transferred outside of Europe, including to Canada and the United States.
          
          Limits on the use of the application: Atom AI users agree that each subscription to the application has a limit of words depending on the chosen subscription. Here are the usage limits:
          
          LITE: €5.99/month (50,000 max words/month) 3-day trial (5,000 words in 3 days) €35.90/year (500,000 max words/year) 3-day trial (5,000 words in 3 days)
          
          PRO: €9.99/month (50,000 max words/month) 7-day trial (5,000 words in 7 days) €59.90/year (500,000 max words/year) 7-day trial (5,000 words in 7 days)
          
          ADVANCED: €19.99/month (100,000 max words/month) 7-day trial (5,000 words in 7 days) €119.90/year (1,000,000 max words/year) 7-day trial (5,000 words in 7 days)
          
          Links to other websites: The Atom AI mobile application may contain links to other websites that are not owned or controlled by us. Please be aware that we are not responsible for these other websites or the privacy practices of third parties. We encourage you to be aware when you leave our mobile application and to read the privacy statements of each and every website that may collect personal data.
          
          Information security: We secure the information you provide on computer servers in a controlled and secure environment, protected from unauthorized access, use or disclosure. We maintain reasonable administrative, technical, and physical safeguards to protect against unauthorized access, use, alteration, and disclosure of personal data under its control and care. However, no data transmission over the Internet or wireless network can be guaranteed.
          
          Legal disclosure: We will disclose any information we collect, use, or receive if required or permitted by law, such as to comply with a subpoena or similar legal process, and when we believe in good faith that disclosure is necessary to protect our rights, your safety or the safety of others, investigate fraud, or respond to a government request.
          
          Contact information: If you wish to contact us to better understand this policy or to contact us regarding any question related to individual rights and your personal information, you can send an email to ''',
                                  style: TextStyle(
                                    color: ColorConstant.indigo5099,
                                    fontSize: getFontSize(
                                      12,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: getHorizontalSize(
                                      0.30,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "support@atomai.fr".tr,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      12,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: getHorizontalSize(
                                      0.30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () {
                    VibrationService.vibrate();

                    Get.toNamed(AppRoutes.boardingScreen);
                  },
                  height: 64,
                  width: 366,
                  text: "msg_accepter_et_continuer".tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
