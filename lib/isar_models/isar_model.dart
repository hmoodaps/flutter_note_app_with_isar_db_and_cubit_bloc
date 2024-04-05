import 'package:isar/isar.dart';

//this line need to generate file
//run this :   flutter pub add isar isar_flutter_libs path_provider
//    then     flutter pub add -d isar_generator build_runner
//then we need to run : dart run build_runner build >>IN TERMINAL
part 'isar_model.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String ? title;

  String ? text;

  DateTime ? createdAt;

}