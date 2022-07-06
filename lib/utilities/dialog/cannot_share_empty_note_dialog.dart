import 'package:flutter/material.dart';
import 'package:note/utilities/dialog/generic_dialog.dart';

Future<void> showCannotShareEmptyNotedialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You Cannot Share an Empty Note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
