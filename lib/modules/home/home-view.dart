import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key("home"),
        title: Text("home pages"),
      ),
      body: Center(
        child: Text("Hello home"),
      ),
    );
  }
}