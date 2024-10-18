import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:yewlow_apps/core/controller/auth-controller.dart';

class LoginView extends StatelessWidget {
  final AuthController metaMaskController = Get.put(AuthController());
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/img/testt.jpg"),
                fit: BoxFit.cover,
                opacity: 0.3),
          ),
          child: Stack(
            children: [
              // Background SVG
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    decoration: const BoxDecoration(),
                  ),
                ),
              ),
              // Konten di atas background
              Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        // padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(5)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: 1,
                            widthFactor: 1.2,
                            // padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Web3 Social platform",
                              style: TextStyle(fontSize: 4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.yellow[600]?.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                      // gradient:  LinearGradient(colors: [
                      //   Colors.yellow,
                      //   Colors.white54
                      // ], tileMode: TileMode.mirror),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 10,
                          blurRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Form(
                          // key: controller.formKey,
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white38)),
                                  ),
                                  child: Obx(() {
                                    return Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          color: Colors.pink[200]),
                                      child: Text(metaMaskController
                                              .walletAddress.value ??
                                          ""),
                                    );
                                  }))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              color: Colors.lime[800]?.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                splashColor: Colors.grey,
                                onTap: () async {
                                  await metaMaskController
                                      .initializeAppKitModal(context);
                                  metaMaskController.connectWallet();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.login,
                                        size: 24,
                                        color: Colors.white54,
                                      ),
                                      Text(
                                        "Connect",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
