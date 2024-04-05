import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app_with_isar_db_and_cubit_bloc/Cubit/cubit.dart';
import 'package:flutter_note_app_with_isar_db_and_cubit_bloc/screens/read_notes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


import '../Cubit/states.dart';
import '../isar_models/isar_model.dart';
import 'edit_notes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  //create Note
  createNote(context , CubitClass cub) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Create a note',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter youre title',
                  label: Text('Title'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descController,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your description',
                  label: Text('Description'),
                ),
                maxLines: 6,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          TextButton(
            onPressed: () {
              cub.addNote(titleController.text, descController.text, DateTime.now());
              descController.clear();
              titleController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CubitClass cub  = CubitClass.get(context);
    //current notes
    List<NoteModel> currentNotes = cub.notes;

    return BlocConsumer<CubitClass, AppState>(
        builder: (context, state) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => createNote(context , cub),
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: const Text('Note',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
          body:  currentNotes.isEmpty
              ? const Center(
            child: Text(
              'there no notes yet \n try to add some ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )
              : ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                return listTileItem(note , context , cub);
                //(title: Text(note.title!),subtitle: Text(note.text!),);
              }),
            ),
        listener: (context, state) {});
  }
  Widget listTileItem(NoteModel note , context  , CubitClass cub) => MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReadeNote(
                title: note.title!,
                desc: note.text!,
                createAt:
                '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}',
              )));
    },
    child: Slidable(
      endActionPane: ActionPane(
        motion: Container(
            color: Colors.red,
            child: IconButton(
                onPressed: () {
                  cub.deleteNote(note.id);
                },
                icon: const Icon(Icons.delete))),
        children: const [],
      ),
      child: Card(
        child: Container(
          color: Colors.blue[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Text(
                note.text!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                      '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateNote(
                                  id: note.id,
                                  title: note.title!,
                                  desc: note.text!,
                                  createAt:
                                  '${note.createdAt?.day}-${note.createdAt?.month}-${note.createdAt?.year} ${note.createdAt?.hour}:${note.createdAt?.minute}',
                                )));
                      },
                      icon: const Icon(
                        Icons.edit_note_outlined,
                        color: Colors.green,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

}
