// @dart=2.11
// ignore_for_file: file_names, use_key_in_widget_constructors,, prefer_const_constructors, curly_braces_in_flow_control_structures, void_checks, library_prefixes
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

final username = TextEditingController();
String img64 = "";
// ignore: prefer_typing_uninitialized_variables
var fileName;

class _AddItemState extends State<AddItem> {
  File _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(mounted)
        {
          _image = File(image.path);
          final bytes = Io.File(image.path).readAsBytesSync();
          img64 = base64Encode(bytes);
          fileName = (image.path.split('/').last);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    int tags = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          icon: Icon(
            LineIcons.arrowLeft,
            color: Colors.white,
            size: 30,
          )),
        elevation: 15,
        shadowColor: Color(0xFF1f193d),
        backgroundColor: Color(0xFF1f193d),
        title: Text(
            AppLocalizations.of(context).additems,
          style: TextStyle(letterSpacing: 1, fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 10,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: _image == null
                      ? Visibility(
                          visible: _image == null ? true : false,
                          child: Image.asset(
                            "images/applogo.png",
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                          ),
                        )
                      : Image.file(
                          _image,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: TextFormField(
                      maxLines: 10,
                      autofocus: false,
                      textInputAction: TextInputAction.newline,
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
                        hintText: AppLocalizations.of(context).entertains,
                        fillColor: Colors.transparent,
                        filled: true,
                      ),
                      style:
                          GoogleFonts.roboto(fontSize: 18, color: Colors.black),
                      controller: username,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
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

                      var connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult != ConnectivityResult.none) {
                        if (img64 == "")
                          Toast(AppLocalizations.of(context).no);
                        else if (username.text == "")
                          Toast(AppLocalizations.of(context).entertains,);
                        else {
                          SharedPreferences shareString =
                              await SharedPreferences.getInstance();
                          var t = shareString.getString("token");
                          await EasyLoading.show(
                            status: AppLocalizations.of(context).wait,
                            maskType: EasyLoadingMaskType.black,
                          );
                          var data = {
                            'PostCategoryId': tags.toString(),
                            'Note': username.text,
                            'ImageBase64String': img64,
                            'ImageName': fileName,
                          };
                          var res = await http.post(
                              Uri.parse(
                                  ('http://myapi74052.somee.com/api/PostInfo/PostInfo')),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type":
                                    "application/x-www-form-urlencoded",
                                'Authorization': 'Bearer $t',
                              },
                              body: data);

                          if (res.statusCode == 200) {
                            Toast("Success");
                            Navigator.pop(context);
                          } else {
                            Toast(AppLocalizations.of(context).servererror);
                          }
                          await EasyLoading.dismiss();
                        }
                      } else {
                        Toast(AppLocalizations.of(context).internet);
                      }
                      await EasyLoading.dismiss();
                  },
                  child: Text(
                    AppLocalizations.of(context).submit,
                    style: TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
