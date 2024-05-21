import 'package:firebase_database/firebase_database.dart';

class Readings {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("HealthCare");

  Future<Map<String, dynamic>> fetchData() async {
    DataSnapshot snapshot = await dbRef.get();
    if (snapshot.value != null && snapshot.value is Map) {
      Map<String, dynamic> healthCareData = Map<String, dynamic>.from(snapshot.value as Map);
      healthCareData['key'] = snapshot.key;
      return healthCareData;
    } else {
      throw Exception("No Readings Available");
    }
  }
}
