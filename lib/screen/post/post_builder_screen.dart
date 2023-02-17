import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/screen/post/sliver_post_grid_screen.dart';
import 'package:busan_univ_matzip/widgets/post/add_post_button.dart';
import 'package:busan_univ_matzip/widgets/post/appBar/app_bar_image_info_widget.dart';
import 'package:busan_univ_matzip/widgets/docs_image_widget.dart';
import 'package:busan_univ_matzip/widgets/post/appBar/app_bar_page_view_index_widget.dart';
import 'package:busan_univ_matzip/widgets/post/post_screen_sliver_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostBuilderScreen extends StatefulWidget {
  const PostBuilderScreen({super.key, required this.data});

  final QuerySnapshot<Map<String, dynamic>> data;

  @override
  State<PostBuilderScreen> createState() => _PostBuilderScreenState();
}

class _PostBuilderScreenState extends State<PostBuilderScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _appBarController =
      PageController(initialPage: 0, viewportFraction: 1.2);
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: _animationDuration);
  late final Animation<double> _opacityAnimation;

  final Duration _animationDuration = const Duration(milliseconds: 300);
  final int _pageViewItemCount = 4;
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
    final docs = querySnapShot.docs[_currentPage].data();
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
                child: AppBarPageViewIndexWidget(
                  pageViewItemCount: _pageViewItemCount,
                  currentPage: _currentPage,
                ),
              ),
              background: PageView.builder(
                controller: _appBarController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                itemCount: _pageViewItemCount,
                itemBuilder: (_, page) {
                  var docs = querySnapShot.docs[page].data();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DocsImageWidget(docs: docs),
                  );
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(21),
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: AppBarImageInfoWidget(docs: docs),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomDelegate(),
          ),
          SliverPostGridScreen(querySnapShot: querySnapShot),
          const SliverToBoxAdapter(child: SizedBox(height: 300)),
        ],
      ),
      floatingActionButton: AddPostButton(
        onPressed: () => _addPost(context),
        offstage: showSliverAppBarListTile,
      ),
    );
  }
}
