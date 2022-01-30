import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/main/navigators/profile/pages/user_profile_page.dart';

class UserProfileNavigatorRouteHandlers {
  static final rootPage = Handler(
    handlerFunc: (_, __) => UserProfilePage(),
  );
}
