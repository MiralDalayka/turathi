import 'package:flutter/material.dart';
import 'package:turathi/core/functions/dialog_signin.dart';
import 'package:turathi/core/models/comment_place_model.dart';
import 'package:turathi/core/services/user_service.dart';
import 'package:turathi/utils/lib_organizer.dart';
import 'package:turathi/view/widgets/comment_place_card.dart';


import '../../../core/services/comment_service.dart';

class CommentsPlace extends StatefulWidget {
  final PlaceModel place;

  const CommentsPlace({Key? key, required this.place}) : super(key: key);

  @override
  State<CommentsPlace> createState() => _CommentsPlaceState();
}

class _CommentsPlaceState extends State<CommentsPlace> {
  TextEditingController _textEditingController = TextEditingController();
  bool isTextFieldEnabled = true;

  int _commentId = 1;

  bool placeHasComments = false;

  @override
  Widget build(BuildContext context) {
    CommentService commentService = CommentService();
    // List<CommentModel> comments = await commentService.getPlaceComments();
    //BACK
    List<Widget> commentWidgets = List.generate(
      demoComments.length,
      (index) {
        if (demoComments[index].placeID == widget.place.id) {
          placeHasComments = true;
          return Padding(
            padding: const EdgeInsets.all(0),
            child: CommentCard(
              commentModel: demoComments[index],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments for ${widget.place.title}',
          style: ThemeManager.textStyle.copyWith(
            color: ThemeManager.primary,
            fontWeight: FontWeight.w800,
            fontFamily: ThemeManager.fontFamily,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
          Padding(
            padding:
                EdgeInsets.all(LayoutManager.widthNHeight0(context, 1) * 0.04),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: LayoutManager.widthNHeight0(context, 1) * 0.005,
                        color: ThemeManager.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(
                      LayoutManager.widthNHeight0(context, 1) * 0.01),
                  child: Column(
                    children: [
                      TextField(
                        controller: _textEditingController,
                        enabled: isTextFieldEnabled,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        maxLength: 83,
                        style: TextStyle(
                          height:
                              LayoutManager.widthNHeight0(context, 1) * 0.01,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          counterText: '',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                LayoutManager.widthNHeight0(context, 1) * 0.65),
                        child: defaultButton3(
                          text: 'Send',
                          borderRadius: 18,
                          background: ThemeManager.primary,
                          textColor: ThemeManager.second,
                          onPressed: () {
                            final currentUser = UserService().auth.currentUser;
                            if (currentUser != null &&
                                currentUser.isAnonymous) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    showCustomAlertDialog(context,
                                        "You Have To SignIn First \nTo Write Comments!"),
                              );
                            } else {
                              setState(() {
                                _commentId++;
                                demoComments.add(PlaceCommentModel(
                                  id: _commentId.toString(),
                                  date: DateTime.now(),
                                  commentTxt: _textEditingController.text,
                                  writerName:
                                      "${sharedUser.name}",
                                  writtenByExpert:
                                      0, ////this is should be change to the current user status
                                  placeID: widget.place.id,
                                ));

                                _textEditingController.clear();
                              });
                            }
                          },
                          borderWidth: 23,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                  LayoutManager.widthNHeight0(context, 1) * 0.05),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    if (placeHasComments) ...commentWidgets,
                    if (placeHasComments == false)
                      Padding(
                        padding: EdgeInsets.only(
                            top:
                                LayoutManager.widthNHeight0(context, 1) * 0.35),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "No Comments On This Place Yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeManager.primary,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      LayoutManager.widthNHeight0(context, 0) *
                                          0.021,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      LayoutManager.widthNHeight0(context, 0) *
                                          0.01),
                              Text(
                                "You're welcome to share your\n thoughts and comments!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: ThemeManager.fontFamily,
                                  fontSize:
                                      LayoutManager.widthNHeight0(context, 0) *
                                          0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
