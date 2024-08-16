import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/core/assets/app_texts.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_bloc.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_event.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message ?? "Something went wrong")),
              );
            } else if (state is OtpSent) {
              Navigator.pushNamed(context, '/otp',
                  arguments: [state.verificationId, state.phoneNumber]);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  61.verticalSpace,
                  Center(
                      child: Image.asset(
                    logInImagePath,
                    width: 130.w,
                    height: 102.74,
                  )),
                  49.29.verticalSpace,
                  Text(
                    'Enter Phone Number',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  16.verticalSpace,
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.w,
                            color: const Color(0x0ff00000).withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(8).w,
                      ),
                      hintText: 'Enter Phone Number *',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000).withOpacity(0.4),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                      ),
                      text: 'By Continuing, I agree to TotalX\’s ',
                      children: [
                        TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: blueColor,
                            ),
                            text: 'Terms and condition '),
                        TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),
                            text: '& '),
                        TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: blueColor,
                            ),
                            text: "privacy policy")
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(328.w, 44.h),
                      backgroundColor: const Color(0xff100E09),
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(SendOtpEvent(_phoneNumberController.text));
                    },
                    child: state is AuthLoading
                        ? Padding(
                            padding: const EdgeInsets.all(7).r,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: whiteColor),
                          )
                        : Text(
                            'Get OTP',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
