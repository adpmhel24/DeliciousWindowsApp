import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  static loading(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          content: SizedBox(
            height: 15.r,
            width: 15.r,
            child: const ProgressRing(),
          ),
        );
      },
    );
  }

  static warning(
    context, {
    String? title,
    String? message,
    List<Widget>? actions,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return ContentDialog(
          title: Wrap(children: [
            const Icon(FluentIcons.warning),
            Text(title ?? "Warning!")
          ]),
          content: Text(message ?? ""),
          actions: actions ??
              [
                Button(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
        );
      },
    );
  }

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
        return SingleChildScrollView(
          child: ContentDialog(
            title: Text(title ?? "Error Message"),
            content: Text(
              message ?? "Something wrong, please check.",
            ),
            actions: actions ??
                [
                  Button(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
          ),
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
