import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/widgets/add_post_button.dart';
import 'package:busan_univ_matzip/widgets/animated_page_view_index_widget.dart';
import 'package:busan_univ_matzip/widgets/docs_image_widget.dart';
import 'package:busan_univ_matzip/widgets/sliver_header_post.dart';
import 'package:busan_univ_matzip/widgets/small_post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class StreamBuilderTestScreen extends StatefulWidget {
  const StreamBuilderTestScreen({super.key, required this.data});

  final QuerySnapshot<Map<String, dynamic>> data;

  @override
  State<StreamBuilderTestScreen> createState() =>
      _StreamBuilderTestScreenState();
}

class _StreamBuilderTestScreenState extends State<StreamBuilderTestScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _appBarController =
      PageController(initialPage: 0, viewportFraction: 1.25);
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: _animationDuration);
  late final Animation<double> _opacityAnimation;

  final Duration _animationDuration = const Duration(milliseconds: 300);
  final int _pageViewItemCount = 4;
  final double _listTileWidthFactor = 0.7;
  int _currentPage = 0;
  bool showSliverAppBarListTile = true;

  @override
  void initState() {
    super.initState();
    addData();
    _scrollController.addListener(() {
      _playSanJiNi();
    });
    setState(() {
      showSliverAppBarListTile = true;
    });
    _opacityAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _appBarController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _playSanJiNi() {
    bool isScreenFullOfAppBar = _scrollController.offset <= 100;

    if (isScreenFullOfAppBar && !showSliverAppBarListTile) {
      _animationController.reverse();
      setState(() {
        showSliverAppBarListTile = true;
      });
    } else if (!isScreenFullOfAppBar && showSliverAppBarListTile) {
      _animationController.forward();
      setState(() {
        showSliverAppBarListTile = false;
      });
    }
  }

  void addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refereshUser();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _addPost(BuildContext context) {
    Navigator.pushNamed(context, '/homePage/addPost');
  }

  @override
  Widget build(BuildContext context) {
    final querySnapShot = widget.data;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            collapsedHeight: kToolbarHeight,
            expandedHeight: size.height * 0.77,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1.2,
              title: FadeTransition(
                opacity: _opacityAnimation,
                child: AnimatedPageViewIndexWidget(
                  pageViewItemCount: _pageViewItemCount,
                  currentPage: _currentPage,
                ),
              ),
              background: PageView.builder(
                controller: _appBarController,
                onPageChanged: _onPageChanged,
                itemCount: _pageViewItemCount,
                itemBuilder: (_, page) {
                  var docs = querySnapShot.docs[page].data();
                  return DocsImageWidget(docs: docs);
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(21),
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ListTile(
                  textColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _listTileWidthFactor,
                      child: Text(
                        querySnapShot.docs[_currentPage]
                            .data()['menu']
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  subtitle: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _listTileWidthFactor,
                    child: Text(
                      querySnapShot.docs[_currentPage]
                          .data()['discription']
                          .toString(),
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Stack(
                    alignment: Alignment.centerRight,
                    clipBehavior: Clip.none,
                    children: const [
                      Positioned(
                        bottom: 35,
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.faceSmileBeam,
                        color: Colors.white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomDelegate(),
          ),
          SliverGrid.builder(
            itemCount: querySnapShot.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 13,
            ),
            itemBuilder: (_, index) => SmallPostWidget(
              docs: querySnapShot.docs[index].data(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 300),
          ),
        ],
      ),
      floatingActionButton: AddPostButton(
        onPressed: () => _addPost(context),
        offstage: showSliverAppBarListTile,
      ),
    );
  }
}
