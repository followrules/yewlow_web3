import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AuthController extends GetxController {
  Rx<String?> walletAddress = Rx<String?>(null);
  late final ReownAppKit appKit;
  ReownAppKitModal? appKitModal; // Nullable untuk menghindari reinitialization
  Rx<String?> signatureResult = Rx<String?>(null); // Rx untuk hasil signature

  @override
  void onInit() async {
    super.onInit();
    appKit = ReownAppKit(
      core: ReownCore(projectId: "638d75e74290a973b28a1c01c999a1cd"),
      metadata: const PairingMetadata(
        name: 'Example App',
        description: 'Example app description',
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
        ),
      ),
    );
  }

  Future<void> initializeAppKitModal(BuildContext context) async {
    // Pastikan hanya menginisialisasi appKitModal sekali
    if (appKitModal == null) {
      appKitModal = ReownAppKitModal(
        context: context,
        appKit: appKit,
      );
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
  }

  void _onAuthResponse(dynamic event) {
    if (event.response != null) {
      // Jika response sukses, ambil alamat wallet
      final address = event.response!.address;
      walletAddress.value = address; // Set address di Rx untuk tampil di UI
    } else {
      print('Autentikasi gagal atau ditolak oleh user.');
    }
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
