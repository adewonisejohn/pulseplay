import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/searchResult.dart';
import 'package:pulseplay/functions/crud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class library_page extends StatefulWidget {
  const library_page({Key? key}) : super(key: key);

  @override
  State<library_page> createState() => _library_pageState();
}

class _library_pageState extends State<library_page> {
  var favorite_playlist = [];

  @override
  void initState() {
    super.initState();
    loadFavoritePlaylist();
  }

  Future<void> loadFavoritePlaylist() async {
    var playlist = await DbTransactions().getPlayList();
    setState(() {
      favorite_playlist = playlist;
    });
    print(favorite_playlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          left: 20,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Text(
                    "Library",
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(CupertinoIcons.shuffle_thick),
                  SizedBox(width: 10),
                  Icon(
                    CupertinoIcons.play_circle_fill,
                    color: Color(0xffA54A1A),
                    size: 50,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20, top: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: favorite_playlist.length > 0
                      ? Column(
                    children: [
                      for (var i in favorite_playlist)
                        Column(
                          children: [
                            Slidable(
                        endActionPane:ActionPane(
                        motion:StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed:((context) async {
                        await DbTransactions().deleteSongById(i['id']);
                        setState(() {
                          favorite_playlist = [];
                        });
                        await loadFavoritePlaylist();

                      }),
                      backgroundColor:Colors.red,
                      icon:Icons.delete,
                    )
                  ],
                ),
                child: Container(
                  width:double.infinity,
                  child:Row(
                    children: [
                      Container(
                        height:50,
                        width:50,
                        margin:EdgeInsets.only(right:10),
                        child:CachedNetworkImage(imageUrl:i['thumbnail'],fit:BoxFit.contain),
                      ),
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Container(
                              width:MediaQuery.of(context).size.width*0.7,
                              child: Text(i['title'],style:GoogleFonts.manrope(fontWeight:FontWeight.bold,color:Colors.black),overflow:TextOverflow.ellipsis,)
                          ),
                          Container(
                              width:MediaQuery.of(context).size.width*0.6,
                              child: Text(i['artist'],style:GoogleFonts.manrope(fontWeight:FontWeight.w600),overflow:TextOverflow.ellipsis,)
                          )
                        ],
                      ),
                      Expanded(child:SizedBox()),
                    ],
                  ),
                ),
              ),
                            SizedBox(height:10,),
                          ],
                        ),
                    ],
                  )
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.25,
                        ),
                        Text(
                          "Your favorite songs will appear here",
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
