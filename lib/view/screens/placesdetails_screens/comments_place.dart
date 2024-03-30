import 'package:flutter/material.dart';
import 'package:turathi/core/models/place_model.dart';
import 'package:turathi/utils/layout_manager.dart';
import 'package:turathi/utils/theme_manager.dart';
import 'package:turathi/view/widgets/comment_card.dart';
import 'package:turathi/view/widgets/comment_circle.dart';
import 'package:turathi/view/widgets/deff_button%203.dart';

class CommentsPlace extends StatefulWidget {
  const CommentsPlace({Key? key}) : super(key: key);

  @override
  State<CommentsPlace> createState() => _CommentsPlaceState();
}

class _CommentsPlaceState extends State<CommentsPlace> {
  TextEditingController _textEditingController = TextEditingController();
  bool isTextFieldEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: ThemeManager.textStyle.copyWith(color: ThemeManager.primary, fontWeight: FontWeight.w800, fontFamily: ThemeManager.fontFamily),
        ),
      ),
      body: Column(
        children: [
          Divider(height: LayoutManager.widthNHeight0(context, 1) * 0.01, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.04),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width:  LayoutManager.widthNHeight0(context, 1) * 0.005, color: ThemeManager.primary), 
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _textEditingController,
                            enabled: isTextFieldEnabled,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: null,
                            maxLength: 94, 
                            style: TextStyle(height: LayoutManager.widthNHeight0(context, 1) * 0.01), 
                            decoration: InputDecoration(
                              border: InputBorder.none, 
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: LayoutManager.widthNHeight0(context, 1) * 0.02,
                          right: LayoutManager.widthNHeight0(context, 1) * 0.03,
                          child: SizedBox(
                            width: LayoutManager.widthNHeight0(context, 1) * 0.25,
                            child: defaultButton3(
                              text: 'Send',
                              width: LayoutManager.widthNHeight0(context, 1) * 0.36,
                              borderRadius: 18,
                              background: ThemeManager.primary,
                              textColor: ThemeManager.second,
                              onPressed: () {
                               //back
                              },
                              borderWidth: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                
                  
                  ],
                           
                
                
                ),

             
              ],
            ),
          ),
        ],
      ),
    );
  }
}
