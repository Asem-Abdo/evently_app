import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.eventCollection)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJason(snapshot.data()!),
          toFirestore: (event, _) => event.toJason(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    var eventsCollection = getEventCollection();
    var docRef = eventsCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
