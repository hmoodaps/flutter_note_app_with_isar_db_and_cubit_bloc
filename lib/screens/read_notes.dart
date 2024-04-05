import 'package:flutter/material.dart';

class ReadeNote extends StatelessWidget {
  final String title;

  final String desc;
  final String createAt;

  const ReadeNote(
      {super.key,
        required this.title,
        required this.desc,
        required this.createAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                readOnly: true,
                enabled: false,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                initialValue: title,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  counterText: 'Created on $createAt',
                  label: const Text('Description'),
                ),
                initialValue: desc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}