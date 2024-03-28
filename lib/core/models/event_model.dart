class EventModel {
  String? id;
  String? name;
  DateTime? date;
  String? description;
  String? address;
  double? longitude;
  double? latitude;
  double? ticketPrice;
  String? creatorName;
  List<String>? images;

  EventModel(
      {this.id,
      this.name,
      this.date,
      this.description,
      this.address,
      this.longitude,
      this.latitude,
      this.ticketPrice = 0,
      this.creatorName,
      this.images});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    description = json['description'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    ticketPrice = json['ticketPrice'];
    creatorName = json['creatorName'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['description'] = this.description;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['ticketPrice'] = this.ticketPrice;
    data['creatorName'] = this.creatorName;
    data['images'] = this.images;
    return data;
  }
}

List<EventModel> events = [
  EventModel(
      longitude: 35.99126052856445,
      latitude: 32.494564056396484,
      name: 'Rabbath Ammon Oriental Bazaar \n Shopping Centre',
      images: [
        'assets/images/img_png/event1.png',
        'assets/images/img_png/event2.png'
      ],
      date: DateTime.now(),
      address: 'Khaled Al-Walid Amman',
      creatorName: 'Alaa',
      ticketPrice: 0,
      description: '''
    @MrPool Yes, same issue with the static members cannot be accessed in initializers. Very frustrating because having the date static makes no sense. – 
Michael T Apr 28, 2020 at 10:33 Michael T Apr 28, 2020 at 10:33
    '''),
  EventModel(
      longitude: 35.99126052856445,
      latitude: 32.494564056396484,
      name: 'Rabbath Ammon Oriental Bazaar \n Shopping Centre',
      images: [
        'assets/images/img_png/event1.png',
        'assets/images/img_png/event2.png',
      ],
      date: DateTime.now(),
      address: 'Khaled Al-Walid Amman',
      creatorName: 'Alaa',
      ticketPrice: 50,
      description: '''
  @MrPool Yes, same issue with the static members cannot be accessed in initializers. Very frustrating because having the date static makes no sense. – 
Michael T Apr 28, 2020 at 10:33 Michael T Apr 28, 2020 at 10:33
    ''')
];
