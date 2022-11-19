import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/common/repository.dart';

import '../common/abstractModel.dart';

class TrackerRepository extends Repository {
  TrackerRepository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;
  // future
  Future getLastEntry<T extends Model>(String collection) async {
    User? user = await FirebaseAuth.instance.currentUser;
    //TODO: needs to be changed but dart can't accept abstract methods for weird reasons
    return (await FirebaseFirestore.instance
            .collection(collection)
            .where('uid', isEqualTo: user?.uid)
            .orderBy("start", descending: false)
            .get())
        .docs
        .map((item) => Model.fromMap<T>(item.data()))
        .toList()
        .last;
  }

  Future getAllEntriesBasedOnDate<T extends Model>(
      String collection, int numOfDays) async {
    int seconds = numOfDays * 86400;
    User? user = await FirebaseAuth.instance.currentUser;
    return (await FirebaseFirestore.instance
            .collection(collection)
            .where('uid', isEqualTo: user?.uid)
            .where('start',
                isGreaterThan: Timestamp(Timestamp.now().seconds - seconds, 0))
            .get())
        .docs
        .map((item) => Model.fromMap<T>(item.data()))
        .toList();
  }

  // // stream
  // Stream<T> getLastEntryStream<T extends Model>() {
  //   //TODO: needs to be changed but dart can't accept abstract methods for weird reasons
  //   return (FirebaseFirestore.instance
  //       .collection(T.toString().toLowerCase())
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((item) => Model.fromMap<T>(item.data()))
  //         .toList()
  //         .last;
  //   }));
  // final x = _firestore.collection('timermodel').snapshots().map((snapshot) {
  //   return snapshot.docs.map((document) {
  //     print(document.data().entries.last);
  //     return TimerModel(uid: document['uid']);
  //   }).toList();
  // });
  // // print(x.toString());
  // return x;
}
