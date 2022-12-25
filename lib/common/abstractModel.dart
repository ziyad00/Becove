import 'package:tracker/tracker/models/timer.dart';

abstract class Model<T> {
  abstract final String? id;

  // Model({this.id});

  Map<String, dynamic>? toMap() {}
  static T fromMap<T extends Model>(Map<String, dynamic> map) {
    switch (T) {
      // case TimerModel:

      //   /// Why the heck without `as T`, does Dart complain:
      //   /// "A value of type 'User' can't be returned from the method 'fromJson' because it has a return type of 'T'."
      //   /// when clearly `User extends Model` and `T extends Model`?
      //   return TimerModel.fromMap(map) as T;

      default:
        throw UnimplementedError();
    }
  }
}
