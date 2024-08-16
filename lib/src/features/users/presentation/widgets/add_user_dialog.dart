import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_bloc.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_event.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_state.dart';

import '../../../../core/assets/app_texts.dart';
import '../../domain/models/user.dart';

class AddUserDialogContent extends StatelessWidget {
  final TextEditingController userNameInputController;
  final TextEditingController userAgeInputController;

  const AddUserDialogContent({
    super.key,
    required this.userNameInputController,
    required this.userAgeInputController,
  });

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          width: 339.w,
          height: 379.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).w,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a new user',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color:  blackColor,
                    ),
                  ),
                  19.verticalSpace,
                  Center(
                    child:state is ImagePickedState ?Image.file(
                            File(state.imagePath),
                            width: 75.w,
                            height: 75.h,
                          ) : 
                    Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.passthrough,
                            children: [
                              Image.asset(
                                userFrameImagePath,
                                width: 75.w,
                                height: 75.h,
                              ),
                              Positioned(
                                top: 60,
                                left: -6,
                                child: Material(
                                  child: InkWell(
                                    onTap: () async{
                                      BlocProvider.of<UserBloc>(context).add(PickImageEvent());
                                     
                                    },
                                    child: Image.asset(
                                      cameraFrameImagePath,
                                      width: 85.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        
                  ),
                  16.verticalSpace,
                  Text(
                    "Name",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: greyishBlackColor,
                    ),
                  ),
                  11.verticalSpace,
                  TextField(
                    controller: userNameInputController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Name",
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10)
                          .w,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8).r,
                        borderSide: BorderSide(
                          color: const Color(0xff00000066).withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Age",
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: greyishBlackColor,
                    ),
                  ),
                  11.verticalSpace,
                  TextField(
                    controller: userAgeInputController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Age",
                      contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10)
                          .w,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8).r,
                        borderSide: BorderSide(
                          color: const Color(0xff00000066).withOpacity(0.4),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  20.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          userNameInputController.text =
                              userAgeInputController.text = "";
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(90.w, 25.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8).w,
                          ),
                          backgroundColor: const Color(0xffCCCCCC),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color:  blackColor,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      ElevatedButton(
                        onPressed: () {
                          String imgPath = "";
                          if (state is ImagePickedState) {
                            imgPath = state.imagePath;
                          }
                          final userName = userNameInputController.text;
                          final userAge =
                              int.tryParse(userAgeInputController.text);

                          if (userName.isNotEmpty && userAge != null) {
                            var user = User(
                                id: '',
                                name: userName,
                                age: userAge,
                                imagePath: imgPath);
                            // Trigger the event to create the user
                            BlocProvider.of<UserBloc>(context)
                                .add(AddUserEvent(user));
                                BlocProvider.of<UserBloc>(context).add(GetUsersEvent(offset: 0, limit: 10));

                            Navigator.of(context, rootNavigator: true).pop();
                          } else {
                            // Handle validation error
                            // You can show a snack bar or dialog to inform the user
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(90.w, 25.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8).w,
                          ),
                          backgroundColor: const Color(0xff1782FF),
                        ),
                        child: Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
