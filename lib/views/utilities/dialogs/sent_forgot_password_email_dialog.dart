import 'package:firebase/views/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> sentForgotPasswordEmailDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Forgot password',
    content:
        'An email has been sent to you, please check your email to reset your password.',
    optionsBuilder: () => {
      'Ok': null,
    },
  ).then((value) => value ?? false);
}
