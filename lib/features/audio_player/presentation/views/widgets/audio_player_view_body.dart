import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/features/audio_player/presentation/manager/audio_player_cubit.dart';

class AudioPlayerViewBody extends StatefulWidget {
  const AudioPlayerViewBody({super.key});

  @override
  State<AudioPlayerViewBody> createState() => _AudioPlayerViewBodyState();
}

class _AudioPlayerViewBodyState extends State<AudioPlayerViewBody> {
  @override
  void initState() {
    super.initState();
    AudioPlayerCubit.get(context).durationChanged();
    AudioPlayerCubit.get(context).positionChanged();
    AudioPlayerCubit.get(context).onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.deepPurpleAccent,
            Colors.deepPurple,
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(AudioPlayerCubit.get(context)
                                .music[AudioPlayerCubit.get(context).currMusic]
                                .coverPhoto),
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  AudioPlayerCubit.get(context)
                      .music[AudioPlayerCubit.get(context).currMusic]
                      .song,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  AudioPlayerCubit.get(context)
                      .music[AudioPlayerCubit.get(context).currMusic]
                      .author,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                builder: (context, state) {
                  return Slider(
                      activeColor: Colors.white,
                      thumbColor: Colors.black,
                      min: 0,
                      max: AudioPlayerCubit.get(context)
                          .duration
                          .inSeconds
                          .toDouble(),
                      value: AudioPlayerCubit.get(context)
                          .position
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) async {

                        final position = Duration(seconds: value.toInt());
                        await AudioPlayerCubit.get(context)
                            .player
                            .seek(position);
                      });
                },
              ),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AudioPlayerCubit.get(context)
                      .formatTime(AudioPlayerCubit.get(context).position)),
                  Text(AudioPlayerCubit.get(context).formatTime(
                      AudioPlayerCubit.get(context).duration -
                          AudioPlayerCubit.get(context).position))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        AudioPlayerCubit.get(context).previousSong();
                        await AudioPlayerCubit.get(context).player.state ==
                            PlayerState.paused|| AudioPlayerCubit.get(context).player.state == PlayerState.stopped
                            ? AudioPlayerCubit.get(context).player.pause()
                            : AudioPlayerCubit.get(context).play();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 31,
                          ),
                        ),
                      )),
                  BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            AudioPlayerCubit.get(context).player.state ==
                                    PlayerState.playing
                                ? AudioPlayerCubit.get(context).player.pause()
                                : AudioPlayerCubit.get(context).play();
                            AudioPlayerCubit.get(context).changePlayOrPause();
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                AudioPlayerCubit.get(context).iconData,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ));
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        AudioPlayerCubit.get(context).nextSong();
                        print(AudioPlayerCubit.get(context).player.state );
                        await AudioPlayerCubit.get(context).player.state ==
                                PlayerState.paused|| AudioPlayerCubit.get(context).player.state == PlayerState.stopped
                            ? AudioPlayerCubit.get(context).player.pause()
                            : AudioPlayerCubit.get(context).play();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 32,
                        ),
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
