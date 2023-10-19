part of 'audio_player_cubit.dart';

@immutable
abstract class AudioPlayerState {}

class AudioPlayerInitial extends AudioPlayerState {}
class AudioPlayerChangeIcon extends AudioPlayerState {}
class AudioPlayerMaxDuration extends AudioPlayerState {}
class AudioPlayerDurationChanged extends AudioPlayerState {}
class AudioPlayerPositionChanged extends AudioPlayerState {}
class AudioPlayerGoNextMusic extends AudioPlayerState {}
class AudioPlayerGoPreviousMusic extends AudioPlayerState {}
class AudioPlayerOnComplete extends AudioPlayerState {}
