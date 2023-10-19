import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.deepPurpleAccent,
          Colors.deepPurple,
        ])),
        child: const Center(
            child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Music Player',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        )),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 55);
}
