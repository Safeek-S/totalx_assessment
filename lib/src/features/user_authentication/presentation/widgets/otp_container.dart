import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFieldOTP(bool first, bool last, BuildContext context, TextEditingController controller) {
  return SizedBox(
    width: 44.w,
    height: 44.h,
    child: AspectRatio(
      aspectRatio: 0.9,
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: const Color(0xffFF5454
),),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 10).r,
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: const Color(0xff100E09)),
            borderRadius: BorderRadius.circular(12).w,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: const Color(0xff100E09)),
            borderRadius: BorderRadius.circular(12).w,
          ),
        ),
      ),
    ),
  );
}
