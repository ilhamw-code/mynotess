import 'package:flutter/material.dart';
import 'package:note/utilities/dialog/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Log Out',
    content: 'Are you sure Log Out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log Out': true,
    },
  ).then((value) => value ?? false);
}
