// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use, import_of_legacy_library_into_null_safe
import 'package:line_icons/line_icons.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddItems.dart';
import 'Avsanpage.dart';
import 'Besnu.dart';
import 'Profile.dart';
import 'Shradhanjali.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Maintabpage extends StatefulWidget {
  @override
  _MaintabpageState createState() => _MaintabpageState();
}




var _role ;
class _MaintabpageState extends State<Maintabpage> {
  int _currentIndex = 0;
  PageController? _pageController;
  Future<bool> _onWillPop() async {
    return (await showDialog(
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
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.yes),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  void initState() {

    _roleCheck();
    super.initState();


    _pageController = PageController();
  }
 _roleCheck() async {
   SharedPreferences shareString = await SharedPreferences.getInstance();
   setState(() {
     _role = shareString.getString('roles');
   });

 }
  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(LineIcons.userCircle,size: 30,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
          elevation: 15,
          shadowColor: Color(0xFF1f193d),
          backgroundColor: Color(0xFF1f193d),
          title: Text(
            AppLocalizations.of(context)!.kanam,
            style: TextStyle(letterSpacing: 1, fontSize: 24),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        //     void roleCheck() async {
        //   SharedPreferences shareString = await SharedPreferences.getInstance();
        //   role = shareString.getString('roles');
        // }
        floatingActionButton: _role == "[Admin]"
            ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddItem(),
                    settings: RouteSettings(arguments: _currentIndex + 1)));
          },
          child: const Icon(
            LineIcons.plus,
            size: 30,
          ),
          backgroundColor: Color(0xFF1f193d),
        )
            :  Container(color: Colors.pink,),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Avsanpage(),
              Besnu(),
              Shradhanjali(),
              Container(
                color: Colors.blue,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          iconSize: 30,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController!.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: Color(0xFF1f193d),
                title: Text(
                  AppLocalizations.of(context)!.avasan,
                  style: GoogleFonts.notoSans(),
                ),
                icon: Icon(LineIcons.frowningFace)),
            BottomNavyBarItem(
                activeColor: Color(0xFF1f193d),
                title: Text(
                  AppLocalizations.of(context)!.besnu,
                  style: GoogleFonts.notoSans(),
                ),
                icon: Icon(LineIcons.users)),
            BottomNavyBarItem(
                activeColor: Color(0xFF1f193d),
                title: Text(
                  AppLocalizations.of(context)!.shradhanjali,
                  style: GoogleFonts.notoSans(),
                ),
                icon: Icon(LineIcons.spa)),
            BottomNavyBarItem(
                activeColor: Color(0xFF1f193d),
                title: Text(
                  AppLocalizations.of(context)!.main,
                  style: GoogleFonts.notoSans(),
                ),
                icon: Icon(LineIcons.campground)),
          ],
        ),
      ),
    );
  }
}
