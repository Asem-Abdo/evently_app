import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String userId) {
    return getUsersCollection()
        .doc(userId)
        .collection(Event.eventCollection)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJason(snapshot.data()!),
          toFirestore: (event, _) => event.toJason(),
        );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.userCollection)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) {
            return MyUser.fromJson(snapshot.data()!);
          },
          toFirestore: (myUser, options) {
            return myUser.toJson();
          },
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String userId) async {
    var querySnapshot = await getUsersCollection().doc(userId).get();
    return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event, String userId) {
    var eventsCollection = getEventCollection(userId);
    var docRef = eventsCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
