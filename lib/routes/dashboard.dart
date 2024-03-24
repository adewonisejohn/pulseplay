import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pulseplay/routes/home.dart';
import 'package:pulseplay/routes/library.dart';
import 'package:pulseplay/routes/search.dart';
import 'package:pulseplay/widgets/bottomsheet.dart';
import 'package:pulseplay/widgets/Controls.dart';
import 'package:rxdart/rxdart.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class PositionData{
  const PositionData(this.position,this.bufferedPositon,this.duration);
  final Duration position;
  final Duration bufferedPositon;
  final Duration duration;

}

class _dashboardState extends State<dashboard> {
  @override
  final PageController _pageController = PageController(initialPage:0);
  late AudioPlayer _audioPlayer;
  var index = 0;

  final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse(
            'https://files.ceenaija.com/wp-content/uploads/music/2022/04/NF_-_Mansion_CeeNaija.com_.mp3'
        ) as Uri,
        tag:MediaItem(
            id:'0',
            title:'Mansion',
            artist:'NF',
            artUri:Uri.parse(
                'https://i.scdn.co/image/ab67616d0000b27395d5d85909d5deb5cee9f311'
            )
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            'https://www.ceenaija.com/wp-content/uploads/2020/02/Sonnie-Badu-Baba-www.CeeNaija.com_.mp3'
        ) as Uri,
        tag:MediaItem(
            id:'2',
            title:'Baba Oh',
            artist:'Sonnie Badu',
            artUri:Uri.parse(
                'https://www.ceenaija.com/wp-content/uploads/2020/02/sonnie-badu-2-scaled.jpg'
            )
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            'https://www.ceenaija.com/wp-content/uploads/music/2021/03/NF_-_When_I_Grow_Up_CeeNaija.com_.mp3'
        ) as Uri,
        tag:MediaItem(
            id:'3',
            title:'When i Grow up',
            artist:'NF',
            artUri:Uri.parse(
                'https://i.ytimg.com/vi/lxRwEPvL-mQ/hqdefault.jpg'
            )
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            'https://files.ceenaija.com/wp-content/uploads/music/2023/09/Pentatonix_-_Please_Santa_Please_Yule_Log__CeeNaija.com_.mp3'
        ) as Uri,
        tag:MediaItem(
            id:'4',
            title:'Please Santa',
            artist:'Pentatonix',
            artUri:Uri.parse(
                'https://www.ceenaija.com/wp-content/uploads/2023/09/Pentatonix-Please-Santa-Please.jpg'
            )
        ),
      )
    ]
  );

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration,Duration?,PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
          (position,bufferedPosition,duration)=>PositionData(
              position,
              bufferedPosition,
              duration!,
          )
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }
  Future<void> _init() async{
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        child:Container(
          color:Colors.white,
          width:MediaQuery.of(context).size.width*0.5,
          height:MediaQuery.of(context).size.height*0.21,
          padding:EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.023,top:MediaQuery.of(context).size.height*0.01,right:10,left:10),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap:(){
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => bottomSheet(audioPlayer:_audioPlayer,positionDataStream:_positionDataStream,)
                    );
                  },
                  child: Container(
                    margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.01),
                    width:double.infinity,
                    padding:EdgeInsets.only(left:6,right:10),
                    decoration:BoxDecoration(
                        color:Color(0xffA54A1A).withOpacity(0.85),
                        borderRadius:BorderRadius.circular(10)
                    ),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<SequenceState?>(
                          stream:_audioPlayer.sequenceStateStream,
                          builder:(context,snapshot){
                            final state = snapshot.data;
                            if(state?.sequence.isEmpty ?? true){
                              return const SizedBox();
                            }
                            final metadata = state!.currentSource!.tag as MediaItem;
                            return Row(
                                  children: [
                                    SizedBox(
                                      height:40,
                                      width:40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child:CachedNetworkImage(imageUrl:metadata.artUri.toString(),fit:BoxFit.contain,),
                                      ),
                                    ),
                                    SizedBox(width:10,),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Container(child: Text(metadata.title.toString(),style:GoogleFonts.mulish(fontWeight:FontWeight.w700,color:Colors.white),overflow:TextOverflow.ellipsis,),width:MediaQuery.of(context).size.width*0.51,),
                                        Container(child: Text(metadata.artist.toString(),style:GoogleFonts.mulish(fontWeight:FontWeight.w400,color:Colors.white),overflow:TextOverflow.ellipsis,),width:MediaQuery.of(context).size.width*0.5)
                                      ],
                                    ),
                                    Expanded(child:SizedBox()),
                                    Align(
                                      alignment:Alignment.centerRight,
                                      child:Row(
                                        children:[
                                          Controls(audioPlayer:_audioPlayer),
                                          SizedBox(width:10,),
                                          IconButton(onPressed:_audioPlayer.seekToNext, icon:Icon(Icons.skip_next,color:Colors.white,size:35))
                                        ],
                                      ),
                                    )
                                  ],
                                );
                          },
                        ),
                        StreamBuilder<PositionData>(
                            stream: _positionDataStream,
                            builder:(context,snapshot){
                              final positionData = snapshot.data;
                              return ProgressBar(
                                progress:positionData?.position ?? Duration.zero,
                                buffered:positionData?.bufferedPositon ?? Duration.zero,
                                total:positionData?.duration ?? Duration.zero,
                                thumbRadius:0,
                                bufferedBarColor:Colors.white.withOpacity(0.3),
                                barHeight:2.0,
                                baseBarColor:Colors.white.withOpacity(0.3),
                                progressBarColor:Colors.white,
                                onSeek:_audioPlayer.seek,
                                timeLabelLocation:TimeLabelLocation.none,
                                );
                            }
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed:(){
                        setState(() {
                          index=0;
                          _pageController.jumpToPage(0);
                        });
                      },
                      icon:Icon(CupertinoIcons.search), color : index==0 ? Colors.black : Color(0xffBEB5B5)
                  ),
                  IconButton(
                    onPressed:(){
                      setState(() {
                        index=1;
                        _pageController.jumpToPage(1);
                      });
                    },
                      icon:Icon(CupertinoIcons.music_albums),color: index==1 ? Colors.black : Color(0xffBEB5B5)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body:Container(
        width:double.infinity,
        height:double.infinity,
        child:PageView(
          physics: NeverScrollableScrollPhysics(),
          controller:_pageController,
          children: [
            search(audioPlayer:_audioPlayer,playlist:_playlist,),
            library_page(),
          ],
        ),
      )
    );
  }
}


