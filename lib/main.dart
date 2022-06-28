import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:whatsapp_direct/constants/app_constants.dart';
import 'package:whatsapp_direct/provider/theme_provider.dart';
import 'package:whatsapp_direct/widget/sheet_items.dart';

import 'constants/app_theme.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.black));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        builder: (context, _) {
          return FutureBuilder<AdaptiveThemeMode>(
              future:
                  Provider.of<ThemeProvider>(context, listen: false).getTheme(),
              initialData: AdaptiveThemeMode.system,
              builder: (context, snapShot) {
                return AdaptiveTheme(
                    light: lightTheme,
                    dark: darkTheme,
                    initial: snapShot.hasData
                        ? snapShot.data ?? AdaptiveThemeMode.system
                        : AdaptiveThemeMode.system,
                    builder: (lightThemeData, darkThemeData) {
                      return MaterialApp(
                        title: 'Flutter Demo',
                        debugShowCheckedModeBanner: false,
                        darkTheme: darkThemeData,
                        theme: lightThemeData,
                        home: const MyClass(),
                      );
                    });
              });
        });
  }
}

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  var phone = "";
  var msg = "";
  var code = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(

            icon: FaIcon(
              FontAwesomeIcons.bars,
              size: 18,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
                  showSlidingBottomSheet(context, builder: (context) {
                return SlidingSheetDialog(
                  elevation: 8,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  cornerRadius: 16,
                  snapSpec: const SnapSpec(
                    snap: true,
                    snappings: [1.0],
                    positioning: SnapPositioning.relativeToAvailableSpace,
                  ),
                  builder: (context, state) {
                    return BottomSheetItems(
                    );
                  },
                );
              });

            }),
        title: const Text("WhatsApp Direct"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg_image.jpg"),
          fit: BoxFit.fill,
          colorFilter:
              ColorFilter.mode(Colors.grey.withOpacity(0.1), BlendMode.dstATop),
        )),
        child: Padding(
          padding: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phone = value;
                },
                decoration: InputDecoration(
                    prefixIcon: Container(
                      child: CountryCodePicker(
                        onChanged: (val) {
                          code = val.toString();
                        },
                        initialSelection: 'IN',
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
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  msg = value;
                },
                maxLines: 8,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    label: Text("Message(Optional)"),
                    hintText: "Message"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    )),
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  AppConstants constants = AppConstants();
                  if (phone.length < 10) {
                    constants.showToast(message: "Enter valid phone number");
                  } else {
                    code = code.replaceAll("+", "");
                    String url = "https://wa.me/$code$phone?text=$msg";
                    constants.openUrl(url: url);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
