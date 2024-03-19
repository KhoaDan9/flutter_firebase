import 'package:firebase/views/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showSentEmailDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Forgot password',
    content:
        'An email has been sent to you, please open it to reset your password.',
    optionsBuilder: () => {
      'Ok': null,
    },
  ).then((value) => value ?? false);
}
