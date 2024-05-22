import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';

import '../../../view_layer.dart';


class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.comment});

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comment.writtenByExpert == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/img_png/userProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.05,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.05,
                          ),
                          Text(
                            comment.writerName!,
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.primary,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "EXPERT",
                        style: TextStyle(
                            color: ThemeManager.primary,
                            backgroundColor:
                                ThemeManager.primary.withOpacity(0.1)),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/img_png/userProfile.png',
                        width: LayoutManager.widthNHeight0(context, 0) * 0.05,
                        height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                      ),
                      Text(
                        comment.writerName!,
                        style: TextStyle(
                          fontFamily: 'KohSantepheap',
                          color: ThemeManager.primary,
                        ),
                      )
                    ],
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(comment.commentTxt!)
          ],
        ),
      ),
    );
  }
}
