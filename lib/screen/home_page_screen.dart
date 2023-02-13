import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/widgets/comment_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_floating_tab_bar/bottom_floating_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _topPageController = PageController(initialPage: 0);
  final PageController _secondPageController = PageController(initialPage: 0);

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  late final Animation<double> _mapOpacityAnimation;
  late final Animation<double> _bottomTabOpacityAnimation;
  late final Animation<double> _sizeAnimation;

  bool _bottomAppear = false;

  int _currentPage = 0;
  double _fractionalFactor = 0.7;
  int _postCount = 1;
  int _bottomNavIndex = 1;

  void _playSanJiNi() {
    if (_scrollController.offset <= 200) {
      if (_bottomAppear) return;
      _animationController.forward();

      _bottomAppear = true;
    } else {
      if (!_bottomAppear) return;
      _animationController.reverse();
      _bottomAppear = false;
    }
    setState(() {});
  }

  void addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refereshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();

    _mapOpacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _bottomTabOpacityAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);

    _sizeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _scrollController.addListener(() {
      _playSanJiNi();
    });
  }

  @override
  void dispose() {
    _topPageController.dispose();
    _secondPageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _onTap() {
    setState(() {
      if (_fractionalFactor == 0.7) {
        _fractionalFactor = 1;
      } else {
        _fractionalFactor = 0.7;
      }
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _topPageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
      _secondPageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageManager imageManager = ImageManager();
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            collapsedHeight: kToolbarHeight,
            expandedHeight: 650,
            // pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                width: 50,
                child: PageView.builder(
                  clipBehavior: Clip.none,
                  controller: _topPageController,
                  onPageChanged: _onPageChanged,
                  itemCount: imageManager.imgSources.length,
                  itemBuilder: (context, page) => Image.asset(
                    imageManager.imgSources[page],
                    fit: BoxFit.scaleDown,
                    scale: 1,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: ListTile(
                textColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _fractionalFactor,
                    child: Text(
                      imageManager.imgTitles[_currentPage]["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                subtitle: GestureDetector(
                  onTap: _onTap,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _fractionalFactor,
                    child: Text(
                      imageManager.imgTitles[_currentPage]["subtitle"]!,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                trailing: Stack(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                      bottom: 35,
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    FaIcon(
                      imageManager.imgFaces[_currentPage],
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // SliverToBoxAdapter(
          //   child: SizeTransition(
          //     sizeFactor: _sizeAnimation,
          //     child: FadeTransition(
          //       opacity: _mapOpacityAnimation,
          //       child: Padding(
          //         padding: const EdgeInsets.only(
          //           top: 10,
          //           left: 10,
          //           right: 10,
          //         ),
          //         child: Container(
          //           color: Colors.amber,
          //           height: 100,
          //           child: PageView.builder(
          //             itemCount: imageManager.imgSources.length,
          //             controller: _secondPageController,
          //             onPageChanged: _onPageChanged,
          //             itemBuilder: (context, page) => Image.network(
          //               "https://graduate.pusan.ac.kr/sites/gspa/images/map.png",
          //               fit: BoxFit.fitWidth,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // SliverListWidget(commentCount: _commentCount),
          // SliverToBoxAdapter(
          //     child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //       height: 35,
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           border: Border.all(color: Colors.black)),
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             IconButton(
          //               padding: const EdgeInsets.only(top: 2.5),
          //               onPressed: () {
          //                 if (_commentCount <= 0) return;
          //                 setState(() {
          //                   _commentCount -= 5;
          //                 });
          //               },
          //               icon: const FaIcon(FontAwesomeIcons.chevronUp),
          //             ),
          //             IconButton(
          //                 padding: const EdgeInsets.only(bottom: 2.5),
          //                 onPressed: () {
          //                   setState(() {
          //                     _commentCount += 5;
          //                   });
          //                 },
          //                 icon: const FaIcon(FontAwesomeIcons.chevronDown))
          //           ])),
          // )),

          SliverStickyHeader.builder(
            builder: (context, state) => Container(
              height: 60.0,
              color: (state.isPinned ? Colors.pink : Colors.lightBlue)
                  .withOpacity(1.0 - state.scrollPercentage),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: const CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 4,
              ),
            ),
          ),

          SliverPersistentHeader(
            // pinned: true,
            delegate: CustomDelegate(),
            floating: true,
          ),
          SliverGrid.builder(
            itemCount: _postCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 300,
              childAspectRatio: 4 / 5,
            ),
            itemBuilder: (context, index) => StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  _postCount = snapshot.data!.docs.length;
                  var docs = snapshot.data!.docs[index].data();
                  return Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(
                            docs['profileImage'].toString(),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text("no Image to show"),
                          ),
                        ),
                        Text("discription: ${docs['discription']}"),
                        Text(
                            "username: ${snapshot.data!.docs[index].data()['username']}"),
                      ],
                    ),
                  );
                } else {
                  return const Text("noData");
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BottomFloatingTabBar(bottomAppear: _bottomAppear),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: "menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.safety_check),
              label: "hi",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.safety_check),
              label: "hi",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.safety_check), label: "hi")
          ]),
    );
  }
}

class SliverListWidget extends StatelessWidget {
  const SliverListWidget({
    super.key,
    required int commentCount,
  }) : _commentCount = commentCount;

  final int _commentCount;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        childCount: _commentCount,
        (context, index) => Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
          ),
          child: CommentWigdet(index: index),
        ),
      ),
      itemExtent: 80,
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print(shrinkOffset);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Posts",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "view all",
                style: TextStyle(fontSize: 16),
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 12,
              ),
            ],
          ),
          secondChild: const Text(
            "Posts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // throw UnimplementedError();
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
