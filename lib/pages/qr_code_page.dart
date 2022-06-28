import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:whatsapp_direct/constants/app_constants.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  TextEditingController phoneController = TextEditingController();
  String phone = "";
  String code = "+91";
  bool isLoading = false;
  final _screenshotController = ScreenshotController();

  saveData({required String phone, required String code}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
    await prefs.setString('code', code);
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone') ?? "";
    code = prefs.getString("code") ?? "+91";
    phoneController = TextEditingController(text: phone);
    setState(() {});
  }



  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Widget buildQR(){
      bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

      return
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: isLoading ?Colors.white:null,
          //   decoration: BoxDecoration(image:DecorationImage(image:  AssetImage("assets/images/bg_image.jpg"),)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (phone.length == 10)
                QrImage(
                  data: "https://wa.me/${code.replaceAll("+", "")}$phone",
                  version: QrVersions.auto,
                  foregroundColor:isLoading?Colors.black: isDark? Colors.white:Colors.black,
                  size: 200.0,

                ),
              if (phone.length == 10) Text("Qr code for $code-$phone",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor),)

            ],
          ),
        );
    }

    void _takeScreenshot() async {
      setState(() {
        isLoading = true;
      });

      final screenShort = await _screenshotController.captureFromWidget(
          buildQR()
      );
      final dir = await pp.getExternalStorageDirectory();
      String currDate = DateTime.now().toString();
      final myImagePath = dir!.path + "/$currDate.png";
      File imageFile = File(myImagePath);
      if (!await imageFile.exists()) {
        await  imageFile.create(recursive: true);
      }
      imageFile.writeAsBytes(screenShort);
      Share.shareFiles(
        [myImagePath],
        subject: "Qr code for $code-$phone",
        text:
        "you can generate your QR code from ${AppConstants().appLink}",
      );
      setState(() {
        isLoading = false;
      });
    }
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Scaffold(
      backgroundColor:isDark? Theme.of(context).appBarTheme.backgroundColor:null,


      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (phone.length == 10)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  side: BorderSide(
                      width: 1.5, color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _takeScreenshot();
                  setState(() {});
                },
                child: isLoading ?
                Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ): Text(
                  "Share QR",
                  style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600),
                ),
              ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),primary: Theme.of(context).primaryColor),

              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());

                if (phone.length != 10) {
                          Fluttertoast.showToast(
                              msg: "Enter a valid phone number",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              webPosition: "center",
                              fontSize: 16.0);
                }

                saveData(phone: phone, code: code);
                setState(() {});
              },
              child: Text("Genrate QR"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 18, right: 18, top: 18),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {});

                phone = value;
              },
              decoration: InputDecoration(
                  prefixIcon: Container(
                    child: CountryCodePicker(
                      onChanged: (val) {
                        code = val.toString();
                      },
                      initialSelection: code,
                      favorite: ['+91', 'IN'],
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Phone"),
            ),
            SizedBox(
              height: 20,
            ),
         buildQR() ],
        ),
      ),
    );
  }
}
