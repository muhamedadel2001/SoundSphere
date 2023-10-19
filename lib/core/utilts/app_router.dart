import 'package:flutter/material.dart';
import 'package:music_player/constants.dart';
import 'package:music_player/features/audio_player/presentation/views/audio_player_view.dart';
import 'package:music_player/features/audio_player/presentation/views/widgets/audio_player_view_body.dart';

import '../../features/splash/presentaion/views/splash_view.dart';

class AppRouter {
  static final AppRouter router = AppRouter();
  late Widget startScreeen;
  Route? onGenerateRoute(RouteSettings routeSettings) {
    startScreeen = const SplashView();
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreeen);
      case audioPlayerScreen:
        return MaterialPageRoute(builder: (_) => const AudioPlayerView());
    }
    return null;
  }
}
