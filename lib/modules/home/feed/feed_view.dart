import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[600],
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 110.0,
              maxHeight: 160.0,
              appBarContent: Container(
                color: Colors.pink[700],
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * (0.13 / 2),
                      left: 0,
                      right: 0,
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Feeds",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.settings,
                                size: 32,
                                color: Colors.white70,
                              )
                            ],
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Trending",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Following",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 1,
              childAspectRatio: 2,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: List<Widget>.generate(17, (index) {
                return GridTile(
                  child: InkResponse(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 5,
                              // left: 5,
                              child: InkWell(
                                onLongPress: () {
                                  _zoomImagesProfile(context);
                                },
                                child: Flex(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 86,
                                          height: 86,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/profile2.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Nancy Jewell Mc donni",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Text(
                                        "Transparency may be the most disruptive and far-reaching innovation to come out of social media.innovation to come out of social media.",
                                        style: TextStyle(color: Colors.black54),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 32,
                                  color: Colors.pink[300],
                                )
                              ],
                            )
                          ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.girl,
                                  size: 32,
                                  color: Colors.pink[300],
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "21",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [Icon(Icons.location_on), Text("10km")],
                            ),
                          ),
                        ],
                      ),
                    ),
                    enableFeedback: true,
                  ),
                );
              }),
            ),
          ),
        ]));
  }

  Future<dynamic> _zoomImagesProfile(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.red,
        child: WidgetZoom(
          heroAnimationTag: "tag",
          closeFullScreenImageOnDispose: false,
          zoomWidget: Image.asset(
            "assets/img/profile1.jpg",
            fit: BoxFit.cover,
          ),
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
