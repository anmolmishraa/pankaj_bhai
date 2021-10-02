// @dart=2.11
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

// ignore: library_prefixes
import 'dart:io' as Io;
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Maintabpage.dart';
import 'main.dart';

// ignore: use_key_in_widget_constructors
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final name = TextEditingController();
final phonenumber = TextEditingController();
final password = TextEditingController();
final email = TextEditingController();
final username = TextEditingController();
String img64 = "";
// ignore: prefer_typing_uninitialized_variables
var fileName;

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  File _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
      final bytes = Io.File(image.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      fileName = (image.path.split('/').last);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Stack(
            children: [
              Image.asset(
                "images/iconsplash.png",
                width: MediaQuery.of(context).size.width * 1,
                fit: BoxFit.cover,
                height: 300,
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        getImage();
                      });
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: _image == null
                                ? Visibility(
                                    visible: _image == null ? true : false,
                                    child: Image.asset(
                                      "images/applogo.png",
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    ),
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                    height: 110,
                                    width: 110,
                                  )),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: Container(
                            height: 35,
                            width: 35,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(LineIcons.camera),
                              iconSize: 25,
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(80)),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 35, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).register,
                            style: GoogleFonts.righteous(
                                fontSize: 45,
                                color: Colors.black54,
                                letterSpacing: 2.5),
                          ),
                          const SizedBox(height: 35),

                          ///username
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
                                textInputAction: TextInputAction.next,
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
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context).uname,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                ),
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.black),
                                controller: username,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          ///phonenumber
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
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context).pnum,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                ),
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.black),
                                controller: phonenumber,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          ///email
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
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
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
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: AppLocalizations.of(context).email,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                ),
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.black),
                                controller: email,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          ///password
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
                                      const TextStyle(color: Colors.grey),
                                  hintText:
                                      AppLocalizations.of(context).password,
                                  fillColor: Colors.transparent,
                                  filled: true,
                                ),
                                style: GoogleFonts.roboto(
                                    fontSize: 18, color: Colors.black),
                                controller: password,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          ///register
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
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
                              onPressed: () async {
                                main1(context);
                              },
                              child: Text(
                                AppLocalizations.of(context).register,
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 23,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          ///login
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                text: TextSpan(
                                    text: AppLocalizations.of(context).account,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueAccent),
                                        text:
                                            AppLocalizations.of(context).singin,
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main1(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    if (username.text == "") {
      Toast("Enter your Full name");
    } else if (phonenumber.text == "") {
      Toast("Enter your Phonenumber");
    } else if (phonenumber.text.length != 10) {
      Toast("Enter valid Phonenumber");
    } else if (email.text == "") {
      Toast("Enter your Email");
    } else if (password.text == "") {
      Toast("Enter your Password");
    } else if (password.text.length <= 5) {
      Toast("Passwords must be at least 6 characters.");
    } else {
      await EasyLoading.show(
        status: 'Please wait',
        maskType: EasyLoadingMaskType.black,
      );
      if (img64 == "") {
        img64 =
            "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";
      }
      var data = {
        'FullName': username.text,
        'Password': password.text,
        'Email': email.text,
        'PhoneNumber': phonenumber.text,
        'ImageBase64': img64,
        'ImageName': fileName,
      };
      var res = await http.post(
          Uri.parse(('http://myapi74052.somee.com/api/account/Register')),
          body: data);
      // var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Toast("Success");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        await EasyLoading.dismiss();
      } else if (res.statusCode == 400) {
        var ph = phonenumber.text;
        await EasyLoading.showError("$ph is already taken.",
            maskType: EasyLoadingMaskType.black,
            duration: const Duration(seconds: 5));
      }
    }
  }
  await EasyLoading.dismiss();
}

// ignore: non_constant_identifier_names
void Toast(String TMsg) {
  Fluttertoast.showToast(
      msg: TMsg,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white);
}
