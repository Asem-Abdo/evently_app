class Event {
  static const String eventCollection = 'Events';

  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;

  Event({
    this.id = '',
    required this.image,
    required this.title,
    required this.description,
    required this.eventName,
    required this.dateTime,
    required this.time,
    this.isFavorite = false,
  });

  Event.fromJason(Map<String, dynamic> data)
    : this(
        id: data['id'],
        image: data['image'],
        title: data['title'],
        description: data['description'],
        eventName: data['eventName'],
        dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
        time: data['time'],
        isFavorite: data['isFavorite'],
      );

  Map<String, dynamic> toJason() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'eventName': eventName,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
    };
  }
}
