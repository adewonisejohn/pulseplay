import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream:audioPlayer.playerStateStream,
      builder:(context,snapshot){
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing  = playerState?.playing;
        if(!(playing ?? false)){
          return IconButton(
            onPressed:audioPlayer.play,
            iconSize:40,
            color:Colors.white,
            icon:const Icon(Icons.play_arrow_rounded),
          );
        }else if(processingState != ProcessingState.completed){
          return IconButton(
            onPressed:audioPlayer.pause,
            iconSize:40,
            color:Colors.white,
            icon:const Icon(Icons.pause_rounded),
          );
        }
        return const Icon(
            Icons.play_arrow_rounded,
            size: 40,
            color:Colors.white
        );
      },
    );
  }
}

