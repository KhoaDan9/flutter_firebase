import 'package:firebase/views/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Sharing',
    content: 'You cannot share empty note!',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
