// @dart=2.11
// ignore_for_file: avoid_print, valid_regexps, unnecessary_string_escapes, import_of_legacy_library_into_null_safe, duplicate_ignore, prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'Maintabpage.dart';
import 'l10n/l10n.dart';
import 'registerpage.dart';
import 'package:connectivity/connectivity.dart';

var islogin;

Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification.title);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(islogin == "IsLogin" ? Maintabpage() : MyApp());
}

final phonenumber = TextEditingController();
final password = TextEditingController();

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // ignore: deprecated_member_use
        accentColor: Color(0xFF1f193d),
      ),
      // locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isObscure = true;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(
              AppLocalizations
                  .of(context)
                  .areyou,
            ),
            content: Text(
              AppLocalizations
                  .of(context)
                  .exitthisApp,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations
                    .of(context)
                    .no),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations
                    .of(context)
                    .yes),
              ),
            ],
          ),
    )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }

    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final routems = event.data["route"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
            child: Stack(
              children: [
                Image.asset(
                  "images/iconsplash.png",
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  fit: BoxFit.cover,
                  height: 300,
                ),
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: 120,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 1,
                      alignment: Alignment.center,
                      child: Image.asset("images/applogo.png"),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80)),
                          color: Colors.white),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations
                                  .of(context)
                                  .login,
                              style: GoogleFonts.balooBhai(
                                  fontSize: 55,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                  letterSpacing: 2.5),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 55,
                              child: Material(
                                elevation: 5,
                                shadowColor: Colors.black45,
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusColor: Colors.transparent,
                                    hintStyle:
                                    GoogleFonts.rubik(color: Colors.grey),
                                    hintText: AppLocalizations
                                        .of(context)
                                        .pnum,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 18,
                                      color: Colors.black),
                                  controller: phonenumber,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 55,
                              child: Material(
                                elevation: 5,
                                shadowColor: Colors.black45,
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: TextFormField(
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: _isObscure,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        }),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusColor: Colors.transparent,
                                    hintStyle:
                                    GoogleFonts.rubik(color: Colors.grey),
                                    hintText:
                                    AppLocalizations
                                        .of(context)
                                        .password,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                  style: GoogleFonts.rubik(
                                      fontSize: 18, color: Colors.black),
                                  controller: password,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  shadowColor: const Color(0xFF1f193d),
                                  primary: const Color(0xFF1f193d),
                                ),
                                onPressed: () {
                                  main1(context);
                                },
                                child: Text(
                                  AppLocalizations
                                      .of(context)
                                      .login,
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2.0,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              height: 50,
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                },
                                child: Text(
                                  AppLocalizations
                                      .of(context)
                                      .forgot,
                                  style: GoogleFonts.rubik(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 0),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: AppLocalizations
                                          .of(context)
                                          .noac,
                                      style: GoogleFonts.rubik(
                                          fontSize: 15, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          style: GoogleFonts.rubik(
                                              fontSize: 15,
                                              color: Colors.blueAccent),
                                          text: AppLocalizations
                                              .of(context)
                                              .signUp,
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Positioned(
                //     top: 35,
                //     child: ),
                // Positioned(
                //     top: 180,
                //     right: 0,
                //     child: )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Map mapResponse;
void main1(BuildContext context) async {
  phonenumber.text = "9979630500";
  password.text = "test#123";
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    if (phonenumber.text == "") {
      Toast(AppLocalizations
          .of(context)
          .enphone);
    } else if (phonenumber.text.length != 10) {
      Toast(AppLocalizations
          .of(context)
          .envalidphone);
    } else if (password.text == "") {
      Toast(AppLocalizations
          .of(context)
          .enpass);
    } else if (password.text.length <= 3) {
      Toast(AppLocalizations
          .of(context)
          .envalidpass);
    } else {
      await EasyLoading.show(
        status: AppLocalizations
            .of(context)
            .wait,
        maskType: EasyLoadingMaskType.black,
      );
      var data = {
        'grant_type': 'password',
        'username': "9979630500",
        'password': "test#123",
      };
      var res = await http.post(
          Uri.parse(('http://myapi74052.somee.com/oauth/token')),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data);
      mapResponse = jsonDecode(res.body);

      if (res.statusCode == 200) {
        SharedPreferences shareString = await SharedPreferences.getInstance();
        String rol = mapResponse['roles'];
        final withoutEquals = rol.replaceAll(RegExp("\""), '');
        shareString.setString('roles', withoutEquals);
        shareString.setString('token', mapResponse['access_token']);
        print("Roles $withoutEquals");
        Toast(AppLocalizations
            .of(context)
            .success);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Maintabpage()),
        );
        await EasyLoading.dismiss();
      } else if (res.statusCode == 400) {
        await EasyLoading.showError(AppLocalizations
            .of(context)
            .validetail,
            maskType: EasyLoadingMaskType.black);
      }
    }
  } else {
    Toast(AppLocalizations
        .of(context)
        .internet);
  }
  await EasyLoading.dismiss();
  throw Exception(AppLocalizations
      .of(context)
      .servererror);
}

// ignore: non_constant_identifier_names
void Toast(String TMsg) {
  Fluttertoast.showToast(
      msg: TMsg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white);
}
