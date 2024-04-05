import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app_with_isar_db_and_cubit_bloc/Cubit/cubit.dart';
import '../Cubit/states.dart';

class UpdateNote extends StatelessWidget {
  final String title;
  final String desc;
  final String createAt;
  final int id;

  UpdateNote({
    super.key,
    required this.title,
    required this.desc,
    required this.createAt,
    required this.id,
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CubitClass cub = CubitClass.get(context);
    titleController.text = title;
    descController.text = desc;
return BlocConsumer< CubitClass, AppState >(builder: (context , state)=> Scaffold(
  appBar: AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      },
      icon: const Icon(Icons.arrow_back_ios),
    ),
    actions: [
      IconButton(
          onPressed: () {
            cub.noteUpdate(id, descController.text,
                titleController.text, DateTime.now());
            Navigator.popUntil(context, ModalRoute.withName('/'));

          },
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ))
    ],
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.black),
            maxLines: null,
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            maxLines: null,
            controller: descController,
            decoration: InputDecoration(
              counterText: 'Created on $createAt',
              labelText: 'Description',
            ),
          ),
        ],
      ),
    ),
  ),
), listener: (context , state){});

  }
}
