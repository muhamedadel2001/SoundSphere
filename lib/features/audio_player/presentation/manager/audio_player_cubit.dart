import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/music_models.dart';
part 'audio_player_state.dart';
class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  static AudioPlayerCubit get(context) =>
      BlocProvider.of<AudioPlayerCubit>(context);
  int currMusic = 0;
  final player = AudioPlayer();
  IconData iconData = Icons.play_arrow;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  List<MusicModels> music = [
    MusicModels(
        author: 'Us',
        song: 'Free Palestine',
        coverPhoto: 'assets/images/palestine.jpg',
        path: 'songs/palestine.mp3'),
    MusicModels(
        author: 'Massari',
        song: 'Real Love',
        coverPhoto: 'assets/images/massari.jpg',
        path: 'songs/massari.mp3'),
    MusicModels(
        author: 'james Brown',
        song: 'Its Man World',
        coverPhoto: 'assets/images/mans.jpg',
        path: 'songs/james.mp3'),
    MusicModels(
        author: 'Sheren Abd Elwahab ',
        song: 'Kda ?  ',
        coverPhoto: 'assets/images/sheren.jpg',
        path: 'songs/sheren.mp3'),
  ];
  void play() async {
    await player.play(AssetSource(music[currMusic].path));

  }

  void changePlayOrPause() {
    if (isPlaying) {
      iconData = Icons.play_arrow;
    }
    if (!isPlaying) {
      iconData = Icons.pause;
    }
    isPlaying = !isPlaying;

    emit(AudioPlayerChangeIcon());
  }

  void durationChanged() async {
    await player.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      emit(AudioPlayerDurationChanged());
    });
  }
  void positionChanged() async {
    await player.onPositionChanged.listen((newDuration) {
      position = newDuration;
      emit(AudioPlayerPositionChanged());
    });
  }
  void onComplete() async {
    player.onPlayerComplete.listen((event) {
      nextSong();
      player.state == PlayerState.paused ? player.pause() : play();
      emit(AudioPlayerOnComplete());
    });
  }
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void nextSong() async {
    if (currMusic == music.length - 1) {
      currMusic = 0;
    } else {
      currMusic++;
    }
    emit(AudioPlayerGoNextMusic());
  }

  void previousSong() async {
    if (currMusic == 0) {
      currMusic = music.length - 1;
    } else {
      currMusic--;
    }
    emit(AudioPlayerGoNextMusic());
  }
}
