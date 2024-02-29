import 'package:esacc_task/core/widgets/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.white,
          strokeAlign: .002,
          strokeWidth: 2,
        ),
        SizedBox(
          width: 20.w,
        ),
        const ButtonText(title: 'Loading...'),
      ],
    );
  }
}
