import 'package:url_launcher/url_launcher.dart';

class LaunchInApp {
  Future<void> launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'could not lauch';
    }
  }
}
