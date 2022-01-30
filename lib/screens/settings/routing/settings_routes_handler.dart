import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/settings/pages/about/about_screen.dart';
import 'package:yulli/screens/settings/pages/accountsettings/account_settings_page.dart';
import 'package:yulli/screens/settings/pages/privacy/privacy_page.dart';
import 'package:yulli/screens/settings/pages/qa/qa_page.dart';
import 'package:yulli/screens/settings/pages/root/settings_root_page.dart';
import 'package:yulli/screens/settings/pages/terms/terms_page.dart';

class SettingsRoutesHandler {
  static final settingsRootPage = Handler(
    handlerFunc: (_, __) => SettingsRootPage(),
  );
  static final aboutPage = Handler(
    handlerFunc: (_, __) => AboutPage(),
  );
  static final termsPage = Handler(
    handlerFunc: (_, __) => TermsPage(),
  );
  static final privacyPage = Handler(
    handlerFunc: (_, __) => PrivacyPage(),
  );
  static final qaPage = Handler(
    handlerFunc: (_, __) => QaPage(),
  );
  static final accountSettingsPage = Handler(
    handlerFunc: (_, __) => AccountSettingsPage(),
  );
}
