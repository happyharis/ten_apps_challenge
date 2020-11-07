import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ten_apps_challenge/notes_app/note_notifer.dart';

import 'note_entry_page.dart';

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteNotifier = Provider.of<NoteNotifier>(context);
    return Theme(
      data: ThemeData(primarySwatch: Colors.green),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              for (var note in noteNotifier.currentNotes)
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 18.0),
                    padding: EdgeInsets.all(8),
                    color: Colors.yellowAccent.shade400,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(note.title),
                            Text('❗️' * note.priority)
                          ],
                        ),
                        Row(
                          children: [
                            Text(note.body),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(convertToDate(note.date)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteEntryPage(),
              ),
            );
          },
          child: Icon(Icons.edit_outlined),
        ),
      ),
    );
  }
}

final dateFormat = DateFormat().add_yMMMMd();
String convertToDate(DateTime date) {
  return dateFormat.format(date);
}
