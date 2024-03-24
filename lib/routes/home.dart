import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        height:double.infinity,
        child:Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height*0.13,
              padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.055,right:15,left:15),
              decoration:BoxDecoration(
                color:Color(0xffFFF6D3),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffE7DCB5),
                    width: 0.5,
                  ),
                ),
              ),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text("Heya!",style:GoogleFonts.manrope(fontWeight:FontWeight.bold,fontSize:17),),
                      Text("Ready to jam?",style:GoogleFonts.manrope(fontWeight:FontWeight.bold,fontSize:10),)
                    ],
                  ),
                  Expanded(child:SizedBox()),
                  Icon(Icons.notifications_outlined,size:22),
                  SizedBox(width:15,),
                  Icon(Icons.settings_outlined,size:22),
                  SizedBox(width:15,),
                  CircleAvatar(
                    radius:18,
                    backgroundColor:Color(0xffEAC53E),
                    child:CircleAvatar(
                      radius:17,
                      backgroundColor:Colors.white,
                      child:Icon(CupertinoIcons.person,color:Colors.black,),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child:Container(
                width:double.infinity,
                decoration:BoxDecoration(
                  gradient:LinearGradient(
                      begin:Alignment.topCenter,
                      end:Alignment.bottomCenter,
                      colors: [
                        Color(0xffFFF5D0),
                        Color(0xffFFFFFF)
                      ]
                  ),
                ),
                child:SingleChildScrollView(
                  child:Column(
                     children: [
                       Container(
                         margin:EdgeInsets.only(top:20),
                         width:MediaQuery.of(context).size.width*0.95,
                         height:MediaQuery.of(context).size.height*0.63,
                         padding:EdgeInsets.only(bottom:25),
                         decoration:BoxDecoration(
                           borderRadius:BorderRadius.circular(8),
                           image:DecorationImage(
                             image:CachedNetworkImageProvider('https://i.scdn.co/image/ab67616d0000b27395d5d85909d5deb5cee9f311'),
                             fit:BoxFit.fill
                           )
                         ),
                         child:Column(
                           mainAxisAlignment:MainAxisAlignment.end,
                           children: [
                             Container(
                               margin:EdgeInsets.only(bottom:17),
                               child:Column(
                                 crossAxisAlignment:CrossAxisAlignment.center,
                                 children: [
                                   Container(
                                     width:MediaQuery.of(context).size.width*0.3,
                                     height:MediaQuery.of(context).size.height*0.05,
                                     margin:EdgeInsets.only(bottom:3),
                                     decoration:BoxDecoration(
                                         color:Color(0xffEAC53E).withOpacity(0.15),
                                         borderRadius:BorderRadius.circular(50)
                                     ),
                                     child:Center(child: Text("Song of the week",style:GoogleFonts.manrope(color:Color(0xffEBBC12),fontSize:11,fontWeight:FontWeight.bold),)),
                                   ),
                                   Text("Mansion",style:GoogleFonts.manrope(color:Colors.white,fontWeight:FontWeight.bold,fontSize:20,shadows: [
                                     Shadow(
                                       color: Colors.black,      // Choose the color of the shadow
                                       blurRadius: 2.0,          // Adjust the blur radius for the shadow effect
                                       offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
                                     ),
                                   ],),),
                                   Text("NF-2022",style:GoogleFonts.manrope(color:Colors.white,fontWeight:FontWeight.w400,shadows: [
                                     Shadow(
                                       color: Colors.black,      // Choose the color of the shadow
                                       blurRadius: 2.0,          // Adjust the blur radius for the shadow effect
                                       offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
                                     ),
                                   ],),)
                                 ],
                               ),
                             ),
                             Container(
                               width:double.infinity,
                               child:Row(
                                 mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Icon(CupertinoIcons.share,color:Colors.white),
                                   Icon(CupertinoIcons.heart,color:Colors.white),
                                   Icon(Icons.play_circle_outline,color:Color(0xffEAC53E),size:50),
                                   Icon(Icons.playlist_play,color:Colors.white),
                                   Icon(Icons.more_vert,color:Colors.white,)
                                 ],
                               ),
                             )
                           ],
                         ),
                       )
                     ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
