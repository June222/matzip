import 'package:busan_univ_matzip/widgets/docs_image_widget.dart';
import 'package:flutter/material.dart';

class SmallPostWidget extends StatelessWidget {
  const SmallPostWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: DocsImageWidget(docs: docs, width: 200, height: 150),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            title: Text(
              "${docs['menu']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${docs['discription']}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
