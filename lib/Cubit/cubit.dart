import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app_with_isar_db_and_cubit_bloc/Cubit/states.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../isar_models/isar_model.dart';

class CubitClass extends Cubit<AppState>{

  static CubitClass get(context) => BlocProvider.of<CubitClass>(context);

  CubitClass() : super(InitState());

   late Isar isar;


  // I N I T I A L I S E
   initDB() async {
    final path = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteModelSchema], directory: path.path);
    fetchNotes();
  }


// lis of note
  final List<NoteModel> notes = [];

// C R E A T E
  addNote(String titleFromUser, String textFromUser , DateTime createdAt) async {
    //create a new note
    final newNote = NoteModel()
      ..text = textFromUser
      ..title = titleFromUser
      ..createdAt = createdAt ;
    //save the note to the db
    await isar.writeTxn(() => isar.noteModels.put(newNote));
    //re-read
    fetchNotes();
  }

// R E A D
  fetchNotes() async {
    List<NoteModel> fetchNote = await isar.noteModels.where().findAll();
    notes.clear();
    notes.addAll(fetchNote);
    emit(InitIsarState());
  }

// U P D A T E
  noteUpdate(int id, String newText, String newTitle , DateTime createdAt) async {
    final currentNote = await isar.noteModels.get(id);
    currentNote?.text != null && currentNote?.title != null
        ? (
    currentNote?.text = newText,
    currentNote?.title = newTitle,
    currentNote?.createdAt = createdAt,


    await isar.writeTxn(() => isar.noteModels.put(currentNote!)),
    await fetchNotes()

    )
        : null;
  }

// D E L E T E
  deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchNotes();
  }
}
