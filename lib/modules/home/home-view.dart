import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yewlow_apps/core/app_pages.dart';
import 'package:yewlow_apps/core/controller/auth-controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController metaMaskController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        key: Key("home"),
        title: Text("home pages"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 120, // Tinggi AppBar tetap 120
            pinned: true, // Tetap di posisi teratas saat di-scroll
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Static SliverAppBar'),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item #$index'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
