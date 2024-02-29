import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothDevicesDropdown extends StatelessWidget {
  const BluetoothDevicesDropdown({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    String? value;
    return Card(
      elevation: 3,
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.grey.withOpacity(.2),
          contentPadding: EdgeInsets.symmetric(vertical: 0.h),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
        ),
        hint: Text(
          'Available Devices',
          style: TextStyle(fontSize: 14.sp),
        ),
        items: items,
        value: value,
        onChanged: (newValue) {
          value = newValue;
        },
        buttonStyleData: ButtonStyleData(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          // decoration: BoxDecoration(border: Border.all(color: Colors.black))
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          openMenuIcon: Icon(
            Icons.arrow_drop_up,
            color: Colors.black,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
        ),
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: const BorderSide(color: Colors.transparent));
}
