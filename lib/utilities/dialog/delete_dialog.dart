import 'package:flutter/material.dart';
import 'package:note/utilities/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure Delete Note?',
    optionsBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}
