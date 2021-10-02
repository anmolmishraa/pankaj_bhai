// ignore_for_file: use_key_in_widget_constructors, file_names, duplicate_ignore, prefer_const_constructors, non_constant_identifier_names, avoid_print, unnecessary_null_comparison, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FullImagepage.dart';
import 'main.dart';

class Shradhanjali extends StatefulWidget {
  @override
  _ShradhanjaliState createState() => _ShradhanjaliState();
}

class _ShradhanjaliState extends State<Shradhanjali> {
  List Response = [];
  Map? mapResponse;
  var role;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    createAlbum();
    _refreshController.refreshCompleted();
  }
  Future createAlbum() async {
    SharedPreferences shareString = await SharedPreferences.getInstance();
    var t = shareString.getString("token");
    role = shareString.getString("roles");
    await EasyLoading.show(
      status: 'Please wait',
      maskType: EasyLoadingMaskType.black,
    );
    final response = await http.get(
      Uri.parse('http://myapi74052.somee.com/api/PostInfo/GetPostList/3'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $t',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      if(mounted)
        {
          setState(() {
            var res = jsonDecode(response.body);
            mapResponse = res;
            Response = mapResponse!['PostInformation'];
          });
        }
    } else {
    }
    await EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    createAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
            padding: role == "[Admin]" ? EdgeInsets.fromLTRB(10, 10, 10, 80): EdgeInsets.all(10),
            itemCount: Response == null ? 0 : Response.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Card(
                  color: Color(0xFF1f193d),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 200.0,
                            margin: EdgeInsets.all(4),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Imageview(),
                                        settings: RouteSettings(
                                            arguments: Response[index]
                                            ['Id'],name: Response[index]['ImagePath'])));
                              },
                              child: Hero(
                                tag: "${Response[index]['Id']}",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    Response[index]['ImagePath'],
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "દુઃખદ અવસાન",
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              Response[index]['Note'],
                              style: GoogleFonts.notoSans(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "પરમ કૃપાળુ પરમેશ્વર તેમના દિવ્ય આત્માને શાંતિ આપે. 🙏🏻🙏🏻",
                              style: GoogleFonts.notoSans(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                      role == "[Admin]" ? Positioned( right: 0,
                        child: GestureDetector(onTap: () async {
                          var id = Response[index]['Id'];
                          deleteAlbum(id);
                        }, child: Container( color: Colors.black.withOpacity(0.7),
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.all(4),
                          child: Icon(LineIcons.alternateTrashAlt,color: Colors.white,),
                        ),),
                      ) : Text(""),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future deleteAlbum(int id) async {
    SharedPreferences shareString = await SharedPreferences.getInstance();
    var t = shareString.getString("token");
    await EasyLoading.show(
      status: 'Please wait',
      maskType: EasyLoadingMaskType.black,
    );
    final response = await http.put(
      Uri.parse('http://myapi74052.somee.com/api/PostInfo/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $t',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        createAlbum();
      });
      Toast("Success");
    } else {
      throw Exception('Failed to create album');
    }
    await EasyLoading.dismiss();
  }
}
