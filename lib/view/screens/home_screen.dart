import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/view/screens/detail_screen.dart';
import 'package:music_app/view/widgets/my_tabs.dart';
import 'package:music_app/view/widgets/app_colors.dart' as AppColors;
import 'dart:convert';

import 'package:music_app/view_model/media_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List populars = [];
  List trends = [];
  List news = [];
  List album = [];
  late TabController _tabController;
  late ScrollController _scrollController;

  loadFromFirebase() async {
    await (MediaViewModel().loadTrend()).then((value) {
      setState(() {
        trends = value;
      });
    });
    await (MediaViewModel().loadPopular()).then((value) {
      setState(() {
        populars = value;
      });
    });
    await (MediaViewModel().loadNew()).then((value) {
      setState(() {
        news = value;
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/album.json")
        .then((s) {
      setState(() {
        album = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    loadFromFirebase();
  }

  Widget _buildPopularPageView() {
    return PageView.builder(
        controller: PageController(viewportFraction: 0.79),
        itemCount: album.isEmpty ? 0 : album.length,
        itemBuilder: (_, i) {
          return Container(
            margin: const EdgeInsets.only(left: 6, right: 6),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(album[i]['img']),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }

  Widget _buildListView(List<dynamic> listSongs) {
    return ListView.builder(
      itemCount: listSongs.isEmpty ? 0 : listSongs.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAudioPage(listSongs[i]),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.tabVarViewColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset: Offset(0, 0),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ]),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(listSongs[i].img!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listSongs[i].title!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          listSongs[i].artist!,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Avenir",
                            color: AppColors.subTitleText,
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.loveColor,
                          ),
                          child: const Text(
                            "Love",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: "Avenir"),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageIcon(
                      AssetImage("images/menu.png"),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(children: const [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.notifications)
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Album",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -28,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: _buildPopularPageView(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        backgroundColor: AppColors.sliverBackground,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 5),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ],
                              ),
                              tabs: [
                                AppTabs(
                                  color: AppColors.menu1Color,
                                  text: "New",
                                ),
                                AppTabs(
                                    color: AppColors.menu2Color,
                                    text: "Popular"),
                                AppTabs(
                                    color: AppColors.menu3Color,
                                    text: "Trending"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListView(news),
                      _buildListView(populars),
                      _buildListView(trends),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
