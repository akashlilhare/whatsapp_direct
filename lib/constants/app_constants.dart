import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  String appLink = "https://akashlilhlare.com";
  String appVersion = "1.0.1";

  openUrl({required String url}) async {
    try {
      var uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalNonBrowserApplication,
      )) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  showToast({required String message}){
   return Fluttertoast.showToast(
        msg: "Enter a valid phone number",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }
}
