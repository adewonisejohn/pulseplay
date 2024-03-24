import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class hotMusic extends StatefulWidget {
  hotMusic({required this.index,required this.name});
  var index;
  var name;

  @override
  State<hotMusic> createState() => _hotMusicState();
}

class _hotMusicState extends State<hotMusic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      margin:EdgeInsets.only(top:10,bottom:10),
      child:Row(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Container(
            color:Color(0xffA54A1A).withOpacity(0.6),
            height:23,
            width:23,
            child:Center(child:Text(widget.index.toString(),style:GoogleFonts.manrope(color:Colors.white,fontWeight:FontWeight.bold),),),
          ),
          SizedBox(width:10,),
          Text(widget.name.toString(),style:GoogleFonts.manrope(fontWeight:FontWeight.bold),)
        ],
      ),
    );
  }
}
