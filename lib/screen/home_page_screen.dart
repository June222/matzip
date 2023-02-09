import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:busan_univ_matzip/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  int _commentCount = 5;

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

  @override
  void initState() {
    super.initState();

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
      // print(_scrollController.offset);
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
            expandedHeight: 450,
            pinned: true,
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
          SliverToBoxAdapter(
            child: SizeTransition(
              sizeFactor: _sizeAnimation,
              child: FadeTransition(
                opacity: _mapOpacityAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    color: Colors.amber,
                    height: 100,
                    child: PageView.builder(
                      itemCount: imageManager.imgSources.length,
                      controller: _secondPageController,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, page) => Image.network(
                        "https://graduate.pusan.ac.kr/sites/gspa/images/map.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
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
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 35,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_commentCount <= 0) return;
                          setState(() {
                            _commentCount -= 5;
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.chevronUp),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _commentCount += 5;
                            });
                          },
                          icon: const FaIcon(FontAwesomeIcons.chevronDown))
                    ])),
          )),
          SliverGrid.builder(
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.white.withGreen(230),
              child: Text("hi#$index"),
            ),
          ),
        ],
      ),
      floatingActionButton: BottomFloatingTabBar(bottomAppear: _bottomAppear),
    );
  }
}
