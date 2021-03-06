import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_direct/constants/app_constants.dart';


class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    AppConstants constants = AppConstants();
    var size = MediaQuery
        .of(context)
        .size;
    TextEditingController _controller = TextEditingController();
    onSend() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo info = await deviceInfo.androidInfo;

      String toSend =
          "version: ${info.version.release.toString()}, brand: ${info.brand
          .toString()}, display : ${size.height.toInt()}x${size.width
          .toInt()}\n\n";

      final Email email = Email(
        body: toSend + "==================================\n\n" +
            _controller.text,
        subject: 'Home Workout Feedback',
        recipients: ['workoutfeedback@gmail.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (e) {
        constants.showToast(message: "Not able to send email",);
      }
    }
    buildSendBtn() {
      return Container(height: 60,
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
        width: size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: () {
          onSend();
        }, child: Text("Submit".toUpperCase()),),);
    }

    buildTerms() {
      return RichText(

        text: TextSpan(children: [
          TextSpan(
              text: "If you love our app please give us a ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme
                      .of(context)
                      .textTheme
                      .headline1!
                      .color)),
          WidgetSpan(
              child: InkWell(
                onTap: () async {
                  constants.openUrl(url: constants.appLink);
                },
                child: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("5",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Theme
                                .of(context)
                                .primaryColor)),
                    Icon(Icons.star_outline, size: 18, color: Theme
                        .of(context)
                        .primaryColor),
                    Text("Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Theme
                                .of(context)
                                .primaryColor)),
                  ],
                ),
              )),
          TextSpan(
              text: " on play store and ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme
                      .of(context)
                      .textTheme
                      .headline1!
                      .color)),
          WidgetSpan(
              child: InkWell(
                onTap: () async {
                  final RenderObject? box = context.findRenderObject();
                  final String text =
                      "Send direct message to anyone without saving them into contects. \n\nDownload the app : ${constants.appLink}";

                  await Share.share(
                    text,
                  );
                },
                child: Text(" Refer",
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .primaryColor)),
              )), TextSpan(
              text: " your friends",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme
                      .of(context)
                      .textTheme
                      .headline1!
                      .color)),
        ]),
      );
    }

    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Scaffold(
      backgroundColor:isDark? Theme.of(context).appBarTheme.backgroundColor:null,
      appBar: AppBar(
        title: Text("Send Feedback"),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do let us know how we are doing", style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5),),
                SizedBox(height: 28,),
                TextField(controller: _controller,
                    maxLines: 6,
                    decoration: InputDecoration(labelText: "Feedback",
                        contentPadding: EdgeInsets.all(12))),
                SizedBox(height: 12,),
                buildTerms(),
              ],
            ),
          ), buildSendBtn()

        ],
      ),
    );
  }
}
