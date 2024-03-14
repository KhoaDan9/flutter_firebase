import 'package:firebase/services/cloud/cloud_note.dart';
import 'package:firebase/views/utilities/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> listNotes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView({
    super.key,
    required this.listNotes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listNotes.length,
      itemBuilder: (context, index) {
        final note = listNotes.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(note);
          },
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
