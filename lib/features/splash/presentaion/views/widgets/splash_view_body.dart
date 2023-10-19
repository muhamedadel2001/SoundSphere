import 'dart:async';
import 'package:music_player/constants.dart' as screens;

import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        screens.audioPlayerScreen,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.deepPurpleAccent,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Center(child: Image.asset('assets/images/music_icon.gif')),
            const Text(
              'MusicPlayer',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
