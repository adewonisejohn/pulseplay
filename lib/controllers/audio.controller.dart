// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
//
//
// class PositionData{
//   const PositionData(this.position,this.bufferedPositon,this.duration);
//   final Duration position;
//   final Duration bufferedPositon;
//   final Duration duration;
//
// }
// class AudioController extends GetxController {
//
//
//   late AudioPlayer _audioPlayer;
//
//   var index = 0;
//
//   final _playlist = ConcatenatingAudioSource(
//       children: [
//         AudioSource.uri(
//           Uri.parse(
//               'https://files.ceenaija.com/wp-content/uploads/music/2022/04/NF_-_Mansion_CeeNaija.com_.mp3'
//           ) as Uri,
//           tag:MediaItem(
//               id:'0',
//               title:'Mansion',
//               artist:'NF',
//               artUri:Uri.parse(
//                   'https://i.scdn.co/image/ab67616d0000b27395d5d85909d5deb5cee9f311'
//               )
//           ),
//         ),
//         AudioSource.uri(
//           Uri.parse(
//               'https://www.ceenaija.com/wp-content/uploads/2020/02/Sonnie-Badu-Baba-www.CeeNaija.com_.mp3'
//           ) as Uri,
//           tag:MediaItem(
//               id:'2',
//               title:'Baba Oh',
//               artist:'Sonnie Badu',
//               artUri:Uri.parse(
//                   'https://www.ceenaija.com/wp-content/uploads/2020/02/sonnie-badu-2-scaled.jpg'
//               )
//           ),
//         ),
//         AudioSource.uri(
//           Uri.parse(
//               'https://www.ceenaija.com/wp-content/uploads/music/2021/03/NF_-_When_I_Grow_Up_CeeNaija.com_.mp3'
//           ) as Uri,
//           tag:MediaItem(
//               id:'3',
//               title:'When i Grow up',
//               artist:'NF',
//               artUri:Uri.parse(
//                   'https://i.ytimg.com/vi/lxRwEPvL-mQ/hqdefault.jpg'
//               )
//           ),
//         ),
//         AudioSource.uri(
//           Uri.parse(
//               'https://files.ceenaija.com/wp-content/uploads/music/2023/09/Pentatonix_-_Please_Santa_Please_Yule_Log__CeeNaija.com_.mp3'
//           ) as Uri,
//           tag:MediaItem(
//               id:'4',
//               title:'Please Santa',
//               artist:'Pentatonix',
//               artUri:Uri.parse(
//                   'https://www.ceenaija.com/wp-content/uploads/2023/09/Pentatonix-Please-Santa-Please.jpg'
//               )
//           ),
//         )
//       ]
//   );
//
//   Stream<PositionData> get _positionDataStream =>
//       Rx.combineLatest3<Duration, Duration,Duration?,PositionData>(
//           _audioPlayer.positionStream,
//           _audioPlayer.bufferedPositionStream,
//           _audioPlayer.durationStream,
//               (position,bufferedPosition,duration)=>PositionData(
//             position,
//             bufferedPosition,
//             duration!,
//           )
//       );
//
// }