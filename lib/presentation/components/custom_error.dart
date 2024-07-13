import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/text_style.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    required this.message,
    this.textStyle,
    this.onRetryClicked,
  });
  final String message;
  final TextStyle? textStyle;
  final VoidCallback? onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(48.r),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(onRetryClicked!=null) IconButton(onPressed: onRetryClicked, icon: const Icon(Icons.refresh),),
          Expanded(
            child: Text(
              message,
              style: textStyle??AppTextStyle.emptyStateStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
