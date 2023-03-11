import 'package:busan_univ_matzip/widgets/docs_image_widget.dart';
import 'package:busan_univ_matzip/widgets/post/like_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SmallPostWidget extends StatefulWidget {
  const SmallPostWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  State<SmallPostWidget> createState() => _SmallPostWidgetState();
}

class _SmallPostWidgetState extends State<SmallPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.hardEdge,
                child: kIsWeb
                    ? DocsImageWidget(docs: widget.docs)
                    : DocsImageWidget(
                        docs: widget.docs, width: 200, height: 150),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: LikeWidget(
                  docs: widget.docs,
                ),
              )
            ],
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            title: Text(
              "${widget.docs['menu']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${widget.docs['discription']}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
