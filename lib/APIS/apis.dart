import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_mangemnet_app/model/tasklists.dart';

import 'package:task_mangemnet_app/model/user.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<void> storeDatabase(String title, int nums) async {
    final dates = DateTime.now().microsecondsSinceEpoch.toString();
    final lists = users(title: title, time: dates, length: nums);
    return await firestore.collection("users").doc(title).set(lists.tojson());
  }

  static Future<bool> taskdeleted(String title) async {  
   
    await firestore.collection("users").doc(title).delete();
    return true;
  }

  static Future<void> updatetask(String title, int nums) async {
    await firestore.collection("users").doc(title).update({"length": nums});
  }

  static Future<void> storesubdatabase(
      String database, String title, String desc, String times) async {
    final dates = DateTime.now().microsecondsSinceEpoch.toString();
    final tasklist =
        task(id: dates, title: title, description: desc, date: times);
    return await firestore
        .collection("users")
        .doc(database)
        .collection("tasks")
        .doc(dates)
        .set(tasklist.tojson());
  }

  static Future<bool> storesubdatabasedeleted(String title, String date) async {
    await firestore.collection("users/$title/tasks").doc(date).delete();
    return true;
  }

  static Future<void> updatedatabase(
      String title, String t, String desc, String date, String id) {
    return firestore.collection('users/$title/tasks').doc(id).update(
      {'title': t, 'description': desc, 'date': date},
    );
  }
}
