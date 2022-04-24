import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelInfo extends StatelessWidget {
  const LabelInfo({
    Key? key,
    required this.label,
    this.child,
    this.labelStyle,
    this.hasBackGround = true,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;
  final Widget? child;
  final bool hasBackGround;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? const TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: hasBackGround
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFeeeee4),
                )
              : null,
          child: child,
        )
      ],
    );
  }
}
