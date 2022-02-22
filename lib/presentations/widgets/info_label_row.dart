import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoLabelRow extends StatelessWidget {
  const InfoLabelRow(
      {Key? key,
      required this.label,
      required this.child,
      this.crossAxisAlignment,
      this.labelOverflow})
      : super(key: key);
  final String label;
  final Widget child;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextOverflow? labelOverflow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: FluentTheme.of(context).typography.bodyLarge,
            overflow: labelOverflow,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          flex: 2,
          child: child,
        ),
      ],
    );
  }
}
