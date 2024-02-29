import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    required this.width,
    required this.onPress,
    this.color,
  }) : super(key: key);
  final Widget child;
  final double width;
  final Color? color;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: width,
      child: ElevatedButton(
        onPressed: onPress,
        style: color != null
            ? Theme.of(context)
                .elevatedButtonTheme
                .style!
                .copyWith(backgroundColor: MaterialStatePropertyAll(color))
            : Theme.of(context).elevatedButtonTheme.style,
        child: child,
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({Key? key, required this.title, this.titleColor})
      : super(key: key);
  final String title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: titleColor ?? Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500),
    );
  }
}

class ButtonTitleWithIcon extends StatelessWidget {
  const ButtonTitleWithIcon(
      {Key? key,
      required this.title,
      required this.iconColor,
      required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 15.w,
        ),
         ButtonText(title: title)
      ],
    );
  }
}
