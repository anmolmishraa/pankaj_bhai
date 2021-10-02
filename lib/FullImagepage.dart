// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Imageview extends StatefulWidget {
  @override
  _ImageviewState createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    var tags = ModalRoute.of(context)!.settings.arguments;
    var image = ModalRoute.of(context)!.settings.name;
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
           setState(() {
             _visible =!_visible;
           });
          },
          child: Visibility(
              child: Hero(
            tag: "$tags",
            child: PhotoView(
                minScale: PhotoViewComputedScale.contained,
                imageProvider: NetworkImage(image.toString())),
          )),
        ),
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Visibility(
            visible: _visible,
              child: Container(
            padding: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            height: 75,
            child: Stack(
              children: [
                Positioned(
                  right: 115,
                  top: 20,
                  child: Text(
                    AppLocalizations.of(context)!.kanam,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
                Positioned(
                    top: 9,
                    left: 10,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          LineIcons.arrowLeft,
                          color: Colors.white,
                          size: 30,
                        )))
              ],
            ),
            color: Color(0xFF1f193d).withOpacity(0.5),
          )),
        )
      ],
    );
  }
}
