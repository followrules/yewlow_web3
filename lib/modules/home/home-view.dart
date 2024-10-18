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
      body: Center(
        child: Flex(direction: Axis.vertical,children: [
          Obx((){
            return Text(metaMaskController.walletAddress.value ?? "");
          }),
          ElevatedButton(
            onPressed: () {
              metaMaskController.disconnectWallet();
            },
            child: Text("disconnect Wallet"),
          )
        ],),
      ),
    );
  }
}