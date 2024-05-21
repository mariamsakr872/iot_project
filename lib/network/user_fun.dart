import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/user.dart';


class UserFun {
  static CollectionReference<Users>getUserCollection () {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<Users>(
      fromFirestore: (snapshot, _) =>
          Users.fromFirestore(snapshot.data()!),
      toFirestore: (value, _) => value.toFirestore(),);
  }

  static Future<void> createUser (Users user) {
    var userCollection = getUserCollection();

    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<Users?> getUser(String? uid) async {
    var doc = getUserCollection().doc(uid);
    var snapshot = await doc.get();
    return snapshot.data();

  }

}