import 'package:fluent_ui/fluent_ui.dart';

class CustomDialog {
  static error(
    context, {
    String? title,
    String? message,
    List<Widget>? actions,
  }) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: Text(title ?? "Error Message"),
          content: Text(message ?? "Something wrong, please check."),
          actions: actions,
        );
      },
    );
  }

  static success(
    context, {
    String? title,
    String? message,
    List<Widget>? actions,
  }) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: Text(title ?? "Success Message"),
          content: Text(message ?? "Congrats"),
          actions: actions,
        );
      },
    );
  }
}
