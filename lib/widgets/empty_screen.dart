import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EmptyScreen extends StatelessWidget {
  ///信息空白页模板
  const EmptyScreen({
    super.key,
    required this.title,
    this.buttonTitle,
    this.onPressed,
    this.canClick = true,
    this.image,
    this.center = true,
  }) : assert(canClick || buttonTitle == null);

  final String title;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final bool canClick;
  final Widget? image;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          image ??
              SvgPicture.asset(
                'images/historyempty.svg',
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.3),
              ),
          SizedBox(height: 10.h),
          if (!canClick)
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.3)),
            ),
          if (canClick)
            RichText(
              text: TextSpan(
                text: title,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withOpacity(0.3)),
                children: [
                  WidgetSpan(
                    child: TextButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                      ),
                      child: Text(buttonTitle!),
                    ),
                  ),
                  const TextSpan(text: "吧"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
