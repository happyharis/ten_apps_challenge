import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_notifer.dart';

class NoteEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteNotifier = Provider.of<NoteNotifier>(context);

    final priority = ValueNotifier(0);
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Title'),
              controller: titleController,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: priority.value,
              icon: Text('Priority'),
              items: List.generate(
                3,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text(index.toString()),
                ),
              ),
              onChanged: (value) => priority.value = value,
            ),
            SizedBox(height: 20),
            TextField(
              controller: bodyController,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Taking note of...',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_outlined),
        onPressed: () {
          final note = Note(
            body: bodyController.text,
            title: titleController.text,
            priority: priority.value,
            date: DateTime.now(),
          );
          noteNotifier.addNote(note);
          // notes.add(note);
          // print(notes);
          Navigator.of(context).pop();

          print(note.toString());
        },
      ),
    );
  }
}
