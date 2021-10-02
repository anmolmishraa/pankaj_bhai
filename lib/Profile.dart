// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, import_of_legacy_library_into_null_safe
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 280,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 230,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2016/11/20/11/34/animal-1842533_960_720.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -2,
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Positioned(
                      top: 145,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(
                              5.0,
                              3.0,
                            ),
                            blurRadius: 10.0,
                          ),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn.pixabay.com/photo/2016/11/20/11/34/animal-1842533_960_720.jpg",
                              fit: BoxFit.cover,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 65,
                        left: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pankaj desai",
                                style: GoogleFonts.roboto(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4.0,
                                        color: Color(0xFF000000),
                                        offset: Offset(3.0, 3.0),
                                      ),
                                    ],
                                    fontSize: 23,
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("9574324008",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.roboto(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4.0,
                                        color: Color(0xFF000000),
                                        offset: Offset(3.0, 3.0),
                                      ),
                                    ],
                                    fontSize: 18,
                                    color: Color(0xFFffffff),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ))
                  ],
                ),
              ),
              // setting
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.userCog,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Settings",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.muktaVaani(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // change password
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.alternateUnlock,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Change password",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.muktaVaani(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Developers
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.laptopCode,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Developer",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.muktaVaani(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // About us
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.headset,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Contact Us",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.muktaVaani(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Logout
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.areyou),
                      content: Text(AppLocalizations.of(context)!.login),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(AppLocalizations.of(context)!.no),
                        ),
                        TextButton(
                          onPressed: () =>    Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          ),
                          child: Text(AppLocalizations.of(context)!.yes),
                        ),
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row( mainAxisAlignment: MainAxisAlignment.start   ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        LineIcons.alternateSignOut,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.muktaVaani(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 30,
              left: 5,
              child: IconButton(
                  splashColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    LineIcons.angleLeft,
                    color: Colors.white,
                    size: 30,
                  )))
        ],
      ),
    );
  }
}
