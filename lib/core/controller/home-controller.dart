import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var selectedIndex = 0.obs; // Observable state untuk menyimpan indeks halaman
  PageController pageController = PageController();
  ScrollController scrollController =
      ScrollController(); // ScrollController untuk mendeteksi scrolling
  var isNavBarVisible = true.obs; // Observable untuk visibilitas BottomNavigationBar


  @override
  void onInit() {
    super.onInit();
     scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        isNavBarVisible.value = false; // Sembunyikan saat scroll ke bawah
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        isNavBarVisible.value = true; // Tampilkan saat scroll ke atas
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // Fungsi untuk mengganti halaman berdasarkan item di BottomNavigationBar
  void changePage(int index) {
    selectedIndex.value = index; // Update indeks yang terpilih
    pageController.jumpToPage(index); // Pindah ke halaman yang sesuai
  }

  // Fungsi untuk memperbarui indeks saat halaman di-swipe
  void onPageChanged(int index) {
    selectedIndex.value = index;
    isNavBarVisible.value = true;
  }
}
