import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:pulseplay/widgets/hotMusic.dart';
import 'package:pulseplay/widgets/searchResult.dart';
import 'package:dio/dio.dart';
import 'package:pulseplay/functions/saveToStorage.dart';
import 'package:pulseplay/functions/crud.dart';

class search extends StatefulWidget {
  search({required this.audioPlayer, required this.playlist});

  final AudioPlayer audioPlayer;
  var playlist;


  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  var search_value="";
  var is_searching = false;
  final dio = Dio();
  var search_list = [];
  String url = 'http://172.20.10.5:2000';

  Future<void> search(value) async {
    print("about to search");
    final response = await dio.get(url+'/search?q=${value.toString()}');
    var data = response.data;
    print(data);
    setState(() {
      search_list = data['data'];
    });
  }

  Future<String>getAudio(video_url) async {
    print(video_url);
    var res ="";
    final response = await dio.get(url+'/musiclink?videoUrl=${video_url.toString()}');
    var data = response.data;
    if(data["status"]==true){
      res = data["data"];
    }else{
      print(data["message"]);
    }

    return res;
  }

  Future<void> play_search(data) async {
    var audio_string = await getAudio(data["url"]);
    final _playlist = ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(
                audio_string
            ) as Uri,
            tag:MediaItem(
                id:audio_string,
                title:data['title'],
                artist:data['artist'],
                artUri:Uri.parse(
                    data['thumbnail']
                ),
            ),
          ),
        ]
    );
    widget.audioPlayer.setAudioSource(_playlist);
    print(data);
    var currentPlaying = {
      'id' : data['song_id'],
      'title' : data["title"],
      'artist' : data["artist"],
      'thumbnail' : data['thumbnail'],
      'url' : data['url']
    };
    saveCurrentlyPlaying(currentPlaying);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        height:double.infinity,
        padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08,right:20,left:20),
        child:SingleChildScrollView(
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text("Search",style:GoogleFonts.manrope(fontWeight:FontWeight.bold,fontSize:20),),
              Container(
                padding:EdgeInsets.only(left:15,right:20,top:2,bottom:2),
                margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                decoration:BoxDecoration(
                  color:Color(0xffF0F0F0),
                  borderRadius:BorderRadius.circular(50)
                ),
                child:TextField(
                  onChanged: (text) {
                    search_value = text;
                    if(search_value.length==0){
                      if(is_searching == true){
                        setState(() {
                          is_searching = false;
                        });
                      }
                    }else{
                      search(text);
                      setState(() {
                        is_searching = true;
                      });
                    }
                  },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(CupertinoIcons.search,color:Color(0xffC2C1BD),),
                      hintText:"Search or paste Youtube link",
                      hintStyle:GoogleFonts.manrope(color:Color(0xffC2C1BD),fontSize:15,fontWeight:FontWeight.w500)
                    )

                )
                ,
              ),
              is_searching?Container(
                margin:EdgeInsets.only(top:20),
                padding:EdgeInsets.only(bottom:100),
                color:Colors.transparent,
                width:double.infinity,
                height:MediaQuery.of(context).size.height*0.7,
                child:SingleChildScrollView(
                  child:Column(
                    children:[
                      for(var i in search_list) GestureDetector(
                        onTap:(){
                          play_search(i);
                        },
                          child: searchResult(title:i['title'], artist:i['artist'], thumbnail:i['thumbnail'])
                      )
                    ],
                  ),
                )
              ):
              Container(
                width:double.infinity,
                margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05),
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text("hot",style:GoogleFonts.manrope(color:Colors.black,fontWeight:FontWeight.bold,fontSize:15),),
                    hotMusic(index:"1",name:"Because of You",),
                    hotMusic(index:"2",name:"Heal the world",),
                    hotMusic(index:"3",name:"When i grow up",),
                    hotMusic(index:"4",name:"Amazing Grace",),
                    hotMusic(index:"5",name:"FAST",)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
