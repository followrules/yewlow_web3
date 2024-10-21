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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 250.0,
              maxHeight: 250.0,
              appBarContent: Container(
                color: Colors.blue,
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
                          Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                            size: 32,
                          ),
                          Text("usernamexxxxx",style: TextStyle(
                            color: Colors.white60,
                            fontSize: 30
                          ),),
                          Icon(Icons.location_on,color: Colors.white,size: 32,)
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width:86,
                        height:86,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lime
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
