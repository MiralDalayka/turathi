class PlaceCommentModel {
  String? id;
  String? placeID;
  DateTime? date;
  String? commentTxt;
  String? writerName;
  int? writtenByExpert;


  PlaceCommentModel({
  this.id,
  this.placeID,
         this.date,
         this.commentTxt,
         this.writerName,
         this.writtenByExpert
  });


}

List<PlaceCommentModel> demoComments = [
  PlaceCommentModel(
    id: "1",
    placeID:"1",
    date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 32),
    commentTxt:"I learned so much about the local history from visiting this place.",
    writerName:"Alaa Jamal",
    writtenByExpert:1,

  ),
  PlaceCommentModel(
    id: "1",
    placeID:"1",
    date: DateTime.now(),
    commentTxt: "The architecture of this place is simply stunning!",
    writerName: "John Smith",
    writtenByExpert: 0,
  ),
  PlaceCommentModel(
    id: "2",
    placeID:"1",

    date: DateTime.now(),
    commentTxt: "Visited this place last summer, it's rich with history!",
    writerName: "Emily Johnson",
    writtenByExpert: 0,
  ),
  PlaceCommentModel(
    id: "3",
    placeID:"2",

    date: DateTime.now(),
    commentTxt: "This place holds so much cultural significance.",
    writerName: "David Brown",
    writtenByExpert: 1,
  ),

   PlaceCommentModel(
    id: "4",
    placeID:"121",

    date: DateTime.now(),
    commentTxt: "As a history enthusiast, I highly recommend this place for its authenticity and preservation efforts.",
    writerName: "Rachel Thompson",
    writtenByExpert: 1,
  ),

];
