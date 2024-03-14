import 'package:flutter/material.dart';
import 'package:turathi/core/models/question_model.dart';

import '../../../../utils/layoutManager.dart';
import '../../../../utils/theme_manager.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({super.key, required this.question});

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          'questionView',
          arguments: question,
        );
      },
      child: Card(
        color: ThemeManager.second,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      question.imageUrl!,
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      question.title!,
                      style: TextStyle(
                        fontFamily: 'KohSantepheap',
                        color: ThemeManager.primary,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            LayoutManager.widthNHeight0(context, 0) * 0.03,
                      ),
                    ),
                    Text(
                      question.questionTxt!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'KohSantepheap',
                        color: ThemeManager.textColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/img_png/userProfile.png',
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.05,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.05,
                          ),
                          Text(
                            question.writer!,
                            style: TextStyle(
                              fontFamily: 'KohSantepheap',
                              color: ThemeManager.primary,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
