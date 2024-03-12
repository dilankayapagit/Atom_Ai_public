import 'package:atomai/admin/web_add_promts/web_add_prompt.dart';
import 'package:atomai/admin/web_home/web_home_page.dart';
import 'package:atomai/admin/web_login_screen/web_login_page.dart';
import 'package:atomai/admin/web_user_page/web_user_page.dart';

import '../app_export.dart';

class WebRouters {
  static const String initialRouter = '/';
  static const String webHomePage = '/web-home-page';
  static const String webUserPage = '/web-user-page';
  static const String webAddPrompt = '/web-add-prompt';

  static List<GetPage> webRouter = [
    GetPage(
      name: initialRouter,
      page: () => const WebLoginPage(),
      children: [
        GetPage(
          name: webHomePage,
          page: () => const WebHomePage(),
          children: [
            GetPage(
              name: "$webUserPage/:id",
              page: () => const WebUserPage(),
            ),
            GetPage(
              name: webAddPrompt,
              page: () => const WebAddPrompt(),
            ),
          ],
        ),
      ],
    ),
  ];
}

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(WebRouters.webHomePage)!.currentPage!],
    );
  }
}
