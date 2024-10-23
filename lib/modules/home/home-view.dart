import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yewlow_apps/core/app_pages.dart';
import 'package:yewlow_apps/core/controller/auth-controller.dart';
import 'package:yewlow_apps/core/controller/home-controller.dart';
import 'package:yewlow_apps/modules/home/channel/channel_view.dart';
import 'package:yewlow_apps/modules/home/feed/feed_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Menginisialisasi HomeController menggunakan GetX
    // final AuthController metaMaskController = Get.put(AuthController());
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: PageView(
        controller: homeController.pageController,
        onPageChanged: homeController.onPageChanged,
        children: <Widget>[
          buildChatsView(context,homeController),
          FeedView(),
          ChannelView(),
          _buildPage("Calls", Colors.orange),
          // _buildPage("Calls", Colors.purple),
        ],
      ),
       bottomNavigationBar: Obx(() => homeController.isNavBarVisible.value
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: homeController.selectedIndex.value,
              onTap: homeController.changePage,
              selectedItemColor: Colors.blue,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.feed),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.groups),
                  label: 'Channel',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.phone),
                  label: 'Calls',
                ),
              ],
            )
          : SizedBox.shrink()), 
      floatingActionButton: Obx(() {
        if (homeController.selectedIndex.value == 0) {
          return FloatingActionButton(
            onPressed: () {
              print("Pesan tombol ditekan!");
            },
            child:
                Icon(Icons.add_comment_sharp, color: Colors.black54, size: 24),
            backgroundColor: Colors.teal[700],
          );
        } else {
          return SizedBox.shrink(); // Menghilangkan FAB jika selectedIndex != 0
        }
      }),
    );
  }

  // Halaman Chats yang menggunakan CustomScrollView dan SliverAppBar
  Widget buildChatsView(BuildContext context,HomeController homeController) {
    return CustomScrollView(
      controller: homeController.scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 120.0,
            maxHeight: 120.0,
            appBarContent: Container(
              color: Colors.teal[700],
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * (0.13 / 2),
                    left: 0,
                    right: 0,
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "WasCap",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 32,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 62,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "All",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Unread",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Favorites",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Channel",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/img/profil.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        direction: Axis.vertical,
                        children: [
                          Text(
                            "John Doe",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sebelumnya, posisi Menparekraf adalah Sandiaga Uno...",
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            childCount: 30,
          ),
        ),
      ],
    );
  }

  // Halaman Feed, Channel, dan Calls sederhana
  Widget _buildPage(String title, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget appBarContent;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.appBarContent,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: appBarContent);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        appBarContent != oldDelegate.appBarContent;
  }
}
