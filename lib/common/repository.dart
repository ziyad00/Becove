import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/common/abstractModel.dart';

class Repository<T extends Model> {
  final user = FirebaseAuth.instance.currentUser;

  Future getEntry<T extends Model>(String collection, String id) async {
    return (await FirebaseFirestore.instance.collection(collection)).doc(id);
  }

  Future getAllEntries<T extends Model>() async {
    //TODO: needs to be changed but dart can't accept abstract methods for weird reasons
    return (await FirebaseFirestore.instance.collection('timermodel').get())
        .docs
        .map((item) => Model.fromMap<T>(item.data()))
        .toList();
  }

  Future addEntryWithAutogeneratedId<T extends Model>(T dataModel) async {
    Map<String, dynamic>? data = dataModel.toMap();
    data?['uid'] = user?.uid;
    await FirebaseFirestore.instance
        .collection(dataModel.runtimeType.toString().toLowerCase())
        .add(data!);
  }

  // updates an existing entry (missing fields won't be touched on update), document must exist
  Future updateEntryWithId<T extends Model>(T dataModel) async {
    await FirebaseFirestore.instance
        .collection(dataModel.runtimeType.toString().toLowerCase())
        .doc(dataModel.id)
        .update(dataModel.toMap()!);
  }

  // adds or updates an existing entry (missing fields will be deleted on update!), document will be created if needed
  Future addOrUpdateWithId<T extends Model>(T dataModel) async {
    await FirebaseFirestore.instance
        .collection(dataModel.runtimeType.toString().toLowerCase())
        .doc(dataModel.id)
        .set(dataModel.toMap()!);
  }

  // deletes the entry with the given document id
  Future deleteEntry<T extends Model>(T dataModel) async {
    await FirebaseFirestore.instance
        .collection(dataModel.runtimeType.toString().toLowerCase())
        .doc(dataModel.id)
        .delete();
  }
}
