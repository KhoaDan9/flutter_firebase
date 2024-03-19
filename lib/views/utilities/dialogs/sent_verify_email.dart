import 'package:firebase/views/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> sentVerifyEmailDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Verify email',
    content:
        'An email has been sent to you, please check your email to verify.',
    optionsBuilder: () => {
      'Ok': null,
    },
  ).then((value) => value ?? false);
}
