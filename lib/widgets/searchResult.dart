import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class searchResult extends StatefulWidget {
  searchResult({required this.title,required this.artist,required this.thumbnail});

  var title;
  var artist;
  var thumbnail;

  @override
  State<searchResult> createState() => _searchResultState();
}

class _searchResultState extends State<searchResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      margin:EdgeInsets.only(bottom:10),
      child:Row(
        children: [
          Container(
            height:50,
            width:50,
            margin:EdgeInsets.only(right:10),
            child:CachedNetworkImage(imageUrl:widget.thumbnail,fit:BoxFit.contain),
          ),
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Container(
                width:MediaQuery.of(context).size.width*0.6,
                  child: Text(widget.title,style:GoogleFonts.manrope(fontWeight:FontWeight.bold,color:Colors.black),overflow:TextOverflow.ellipsis,)
              ),
              Container(
                  width:MediaQuery.of(context).size.width*0.6,
                  child: Text(widget.artist,style:GoogleFonts.manrope(fontWeight:FontWeight.w600),overflow:TextOverflow.ellipsis,)
              )
            ],
          ),
          Expanded(child:SizedBox()),
          Icon(Icons.play_circle_fill,size:23)
        ],
      ),
    );
  }
}
