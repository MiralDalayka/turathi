import 'package:flutter/material.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/add_button.dart';

import '../../../core/models/question_model.dart';
import '../../../utils/layout_manager.dart';
import '../../widgets/back_arrow_button.dart';
import 'widgets/question_box.dart';
import 'widgets/question_dialog.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: AddButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return QuestionDialog();
            },
          );
        },
      ),
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        backgroundColor: ThemeManager.background,
        toolbarHeight: LayoutManager.widthNHeight0(context, 0) * 0.06,
        title: Text(
          "Community",
          style: TextStyle(
              fontFamily: ThemeManager.fontFamily,
              color: ThemeManager.primary,
              fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: SizedBox(
        //   height: LayoutManager.widthNHeight0(context, 0),
        //   child: ListView.separated(
        //       itemBuilder: (context, index) {
        //         return QuestionBox(
        //           question: questions[index],
        //         );
        //       },
        //       separatorBuilder: (context, index) => const SizedBox(
        //             height: 5,
        //           ),
        //       itemCount: questions.length),
        // ),
      ),
    );
  }
}

