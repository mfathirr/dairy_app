import 'package:flutter/material.dart';

class NotesAddPage extends StatelessWidget {
  const NotesAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new notes"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Content'),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text('Is Pin'),
                  Switch(value: false, onChanged: (value) {})
                ],
              ))
        ],
      ),
    );
  }
}
