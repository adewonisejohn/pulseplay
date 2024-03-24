import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:like_button/like_button.dart';
import 'package:pulseplay/widgets/Controls.dart';
import 'package:pulseplay/functions/crud.dart';
import 'package:pulseplay/functions/saveToStorage.dart';

import '../routes/dashboard.dart';

class bottomSheet extends StatefulWidget {
  const bottomSheet({super.key, required this.audioPlayer,required this.positionDataStream});

  final AudioPlayer audioPlayer;
  final positionDataStream;


  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
      stream:widget.audioPlayer.sequenceStateStream,
      builder:(context,snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) {
          return const SizedBox();
        }
        final metadata = state!.currentSource!.tag as MediaItem;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffA54A1A),
                  Color(0xff4A2D1E),
                ]
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.05, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                          Icons.expand_more, color: Colors.white, size: 24)
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.65,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                metadata.artUri.toString()),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,),
                  Text(metadata.title, style: GoogleFonts.manrope(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      color: Color(0xffEAC53E)),),
                  Text(metadata.artist.toString(), style: GoogleFonts.manrope(
                      decoration: TextDecoration.none,
                      fontSize: 11,
                      color: Colors.white),),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03, bottom: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed:() async {
                      var song_data  = await getCurrentlyPlayed();
                      await DbTransactions().saveToPlayList(song_data);
                    },
                      icon:Icon(Icons.favorite,size:25,color:Colors.white)
                    ),
                    IconButton(onPressed: widget.audioPlayer.seekToPrevious,
                        icon: Icon(Icons.skip_previous_outlined, size: 30,
                            color: Colors.white)),
                    Controls(audioPlayer: widget.audioPlayer),
                    IconButton(onPressed: widget.audioPlayer.seekToNext,
                        icon: Icon(Icons.skip_next_outlined, size: 30,
                            color: Colors.white)),
                    IconButton(
                      onPressed:(){
                        widget.audioPlayer.setLoopMode(LoopMode.one);
                      },
                        icon: Icon(Icons.loop_outlined, color: Colors.white, size: 25)
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: StreamBuilder<PositionData>(
                    stream: widget.positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return ProgressBar(
                        progress: positionData?.position ?? Duration.zero,
                        buffered: positionData?.bufferedPositon ??
                            Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        thumbRadius: 7,
                        thumbColor: Color(0xffEAC53E),
                        bufferedBarColor: Colors.white.withOpacity(0.5),
                        barHeight: 5.0,
                        baseBarColor: Colors.white.withOpacity(0.3),
                        progressBarColor: Color(0xffEAC53E),
                        onSeek: widget.audioPlayer.seek,
                        timeLabelLocation: TimeLabelLocation.below,
                        timeLabelType: TimeLabelType.remainingTime,
                        timeLabelTextStyle: GoogleFonts.manrope(color: Colors
                            .white),
                      );
                    }
                )
                ,
              )
            ],
          ),
        );
      }
      )
    );
  }
}
