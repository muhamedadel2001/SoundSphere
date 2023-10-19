import 'package:flutter/material.dart';
import 'package:music_player/core/widgets/cutom_appbar.dart';
import 'package:music_player/features/audio_player/presentation/views/widgets/audio_player_view_body.dart';

class AudioPlayerView extends StatelessWidget {
  const AudioPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:CustomAppBar(),
      body: const SafeArea(child: AudioPlayerViewBody()),
    );
  }
}
