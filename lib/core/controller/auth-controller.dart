import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:yewlow_apps/core/app_pages.dart';

class AuthController extends GetxController {
  Rx<String?> walletAddress = Rx<String?>(null);
  late final ReownAppKit appKit;
  ReownAppKitModal? appKitModal; // Nullable untuk menghindari reinitialization
  Rx<String?> signatureResult = Rx<String?>(null); // Rx untuk hasil signature
  // RxBool buttonConnect = false.obs;
  // RxBool buttonSign = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initAppKit();
  }

  Future<void> initAppKit() async {
    appKit = ReownAppKit(
      core: ReownCore(projectId: "638d75e74290a973b28a1c01c999a1cd"),
      metadata: const PairingMetadata(
        name: 'Yewlow App',
        description: 'Social web3 apps',
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
        ),
      ),
    );
    initializeAppKitModal(Get.context!);
  }

  Future<void> initializeAppKitModal(BuildContext context) async {
    final testNetworks = ReownAppKitModalNetworks.test['eip155'] ?? [];
    ReownAppKitModalNetworks.addNetworks('eip155', testNetworks);

    final Set<String> featuredWalletIds = {
      'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
      '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // Trust
      // 'c03dfee351b6fcc421b4494ea33b9d4b92a984f87aa76d1663bb28705e95034a', // uni Wallet
      // '38f5d18bd8522c244bdd70cb4a68e0e718865155811c043f052fb9f1c51de662', // uni Wallet
      '971e689d0a5be527bac79629b4ee9b925e82208e5168b733496a09c0faed0709', // uni Wallet
    };
    if (appKitModal == null) {
      appKitModal = ReownAppKitModal(
          context: context,
          appKit: appKit,
          featuredWalletIds: featuredWalletIds);
      await appKitModal!.init();
    }
  }

  void connectWallet() {
    // Pastikan appKitModal sudah diinisialisasi
    if (appKitModal != null) {
      appKitModal!.openModalView();
    } else {
      print("AppKitModal belum diinisialisasi!");
    }
    walletAddress.value = appKitModal?.session?.address!;
    // buttonConnect.value = true;
    // buttonSign.value = true;
  }

  Future<void> signMessage(String message) async {
    _openWallet();
    if (appKitModal != null &&
        appKitModal!.session != null &&
        appKitModal!.selectedChain != null) {
      final bytes = utf8.encode(message);
      final encodedMessage = hex.encode(bytes);

      try {
        final result = await appKitModal!.request(
          topic: appKitModal!.session!.topic,
          chainId: appKitModal!.selectedChain!.chainId,
          request: SessionRequestParams(
            method: 'personal_sign',
            params: [
              '0x$encodedMessage',
              appKitModal!.session!.address!,
            ],
          ),
        );

        signatureResult.value = result as String;
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        print('Error signing message: $e');
      }
    } else {
      print("AppKitModal atau session belum diinisialisasi.");
    }
  }

  Future<void> _openWallet() async {
    if (appKitModal != null) {
      try {
        appKitModal!.launchConnectedWallet();
      } catch (e) {
        print('Error membuka wallet: $e');
      }
    } else {
      print("AppKitModal belum diinisialisasi.");
    }
  }
}
