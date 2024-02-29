import 'package:esacc_task/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,  this.controller,required this.hint,required this.validator})
      : super(key: key);
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.bodySmall,
          size: 20,
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding: EdgeInsets.symmetric( horizontal: 2.w),
        filled: true,
        fillColor:  const Color(0xffEEF1F4),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        disabledBorder: _border(),
      ),
      cursorHeight: 20.h,
      cursorColor: Theme.of(context).indicatorColor,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: .8,
          color: Theme.of(context).primaryColorDark,
          ),
      validator: validator,
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: const BorderSide(color: Colors.transparent));
}
