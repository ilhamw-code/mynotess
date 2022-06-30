import 'package:flutter/material.dart';
import 'package:note/utilities/dialog/generic_dialog.dart';

Future<void> showDialogError(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error occured',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
