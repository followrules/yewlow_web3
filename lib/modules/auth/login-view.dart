import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yewlow_apps/core/controller/auth-controller.dart';

class LoginView extends StatelessWidget {
  final AuthController metaMaskController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MetaMask Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Text(metaMaskController.walletAddress.value ?? "n/a");
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await metaMaskController.initializeAppKitModal(context);
                metaMaskController.connectWallet();
                // metaMaskController.appKitModal();
              },
              child: Text('connect wallet'),
            ),
            Obx(() => Text(
                  // Tampilkan hasil signature
                  'Signature: ${metaMaskController.signatureResult.value ?? "No signature"}',
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (metaMaskController.walletAddress.value != null) {
                  // Sign pesan
                  await metaMaskController.signMessage('Hello from Flutter!');
                  // await metaMaskController.openWallet();
                } else {
                  print('Wallet belum terkoneksi');
                }
              },
              child: Text('SIGN MESSAGE'),
            ),
          ],
        ),
      ),
    );
  }
}
