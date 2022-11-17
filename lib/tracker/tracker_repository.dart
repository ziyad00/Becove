import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/common/repository.dart';
import 'package:tracker/tracker/timer_model.dart';

import '../common/abstractModel.dart';

class TrackerRepository extends Repository {
  TrackerRepository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;

  Future getAllEntries() async {
    //TODO: needs to be changed but dart can't accept abstract methods for weird reasons
    return (await FirebaseFirestore.instance.collection('timermodel').get())
        .docs
        .map((item) => TimerModel.fromMap(item.data()))
        .toList();
  }

  getLastEntry<T extends Model>() {
    //TODO: needs to be changed but dart can't accept abstract methods for weird reasons
    return (FirebaseFirestore.instance
        .collection(T.toString().toLowerCase())
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((item) => Model.fromMap<T>(item.data()))
          .toList();
      // .last;
    }));
    // final x = _firestore.collection('timermodel').snapshots().map((snapshot) {
    //   return snapshot.docs.map((document) {
    //     print(document.data().entries.last);
    //     return TimerModel(uid: document['uid']);
    //   }).toList();
    // });
    // // print(x.toString());
    // return x;
  }
}
