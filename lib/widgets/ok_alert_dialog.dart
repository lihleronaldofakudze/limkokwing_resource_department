import 'package:fluent_ui/fluent_ui.dart';

ContentDialog okAlertDialog(
    {required BuildContext context,
    required String title,
    required String message}) {
  return ContentDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      FilledButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ],
  );
}
