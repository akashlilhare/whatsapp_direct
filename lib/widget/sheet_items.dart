import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:whatsapp_direct/constants/app_constants.dart';
import 'package:whatsapp_direct/pages/feedback_page.dart';

import '../pages/privacy_policy_page.dart';
import '../pages/qr_code_page.dart';
import '../provider/theme_provider.dart';

class BottomSheetItems extends StatelessWidget {
  const BottomSheetItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants _constants = AppConstants();

    buildTile(
        {required IconData icon,
        required String title,
        Widget? trailing,
        required Function onPress}) {
      return InkWell(
        onTap: () => onPress(),
        child: Container(
          height: 55,
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(icon),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              SizedBox(
                width: 18,
              ),
              trailing ?? Container(),
            ],
          ),
        ),
      );
    }

    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Material(
      color: isDark?Theme.of(context).appBarTheme.backgroundColor:null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(Icons.lightbulb_outline),
              SizedBox(
                width: 20,
              ),
              Text(
                "Theme",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Consumer<ThemeProvider>(builder: (context, data, _) {
                return ToggleSwitch(
                  initialLabelIndex: data.switchIndex,
                  totalSwitches: 3,
                  cornerRadius: 30,
                  fontSize: 14,
                  inactiveBgColor:
                      Theme.of(context).primaryColor.withOpacity(.2),
                  radiusStyle: true,
                  labels: ['Light', 'Dark', 'Auto'],
                  onToggle: (index) {
                    if (index != null) {
                      data.setTheme(index: index, context: context);
                    }
                  },
                );
              }),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          buildTile(
            icon: Icons.ios_share,
            title: "Share With Friends",
            onPress: () async {
              Navigator.of(context).pop();
              final RenderObject? box = context.findRenderObject();
              final String text =
                  "Send direct message to anyone without saving them into your contect. \n\nDownload the app : ${_constants.appLink}";

              await Share.share(
                text,
              );
            },
          ),
          buildTile(
              icon: Icons.star_rate_outlined,
              title: "Rate us",
              onPress: () {
                Navigator.of(context).pop();
                _constants.openUrl(url: _constants.appLink);
              }),
          buildTile(
              icon: Icons.qr_code,
              title: "Generate QR",
              onPress: () {
                Navigator.of(context).pop();

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => QRCodePage()));
              }),
          buildTile(
              icon: Icons.email_outlined,
              title: "Send Feedback",
              onPress: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => FeedbackPage()));

              }),
          buildTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              onPress: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => PrivacyPolicy()));

              }),
          Divider(
            thickness: 1,
          ),
          Center(
            child: Text(
              "Version: ${_constants.appVersion}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
