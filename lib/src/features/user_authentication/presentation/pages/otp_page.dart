import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/core/assets/app_texts.dart';
import 'package:totalx_assessment/src/core/utils/utils.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_bloc.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_event.dart';
import 'package:totalx_assessment/src/features/user_authentication/presentation/bloc/auth_state.dart';

import '../widgets/otp_container.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String verificationId = "", phoneNumber = "", countdownText = "";
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    otpController5.dispose();
    otpController6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    verificationId = args[0];
    phoneNumber = args[1];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
          Navigator.pushNamed(context, '/dashboard');
            }
          },
          builder: (context, state) {
            Widget countdownWidget = const SizedBox.shrink();
            if (state is OtpCountdownState && state.remainingTime > 1) {
              countdownWidget = Text("${state.remainingTime} secs",
                  style: GoogleFonts.montserrat(
                      color: const Color(0xffFF5454),
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp));
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  42.verticalSpace,
                  Center(
                    child: Image.asset(
                     otpImagePath,
                      width: 140.w,
                      height: 140.h,
                    ),
                  ),
                  31.verticalSpace,
                  Text(
                    'OTP Verification',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: greyishBlackColor),
                  ),
                  24.verticalSpace,
                  Text(
                    "Enter the verification code we just sent to your number ${phoneNumber.mask()}",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff000000),
                    ),
                  ),
                  23.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textFieldOTP(true, false, context, otpController1),
                      textFieldOTP(false, false, context, otpController2),
                      textFieldOTP(false, false, context, otpController3),
                      textFieldOTP(false, false, context, otpController4),
                      textFieldOTP(false, false, context, otpController5),
                      textFieldOTP(false, true, context, otpController6),
                    ],
                  ),
                  15.verticalSpace,
                  Center(child: countdownWidget),
                  24.verticalSpace,
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Don't Get OTP? ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: greyishBlackColor,
                          ),
                          children: [
                            TextSpan(
                              
                              text: "Resend",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: blueColor,
                              ),
                            )
                          ]),
                    ),
                  ),
                  17.verticalSpace,
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        String otp = otpController1.text +
                            otpController2.text +
                            otpController3.text +
                            otpController4.text +
                            otpController5.text +
                            otpController6.text;

                        context
                            .read<AuthBloc>()
                            .add(VerifyOtpEvent(verificationId, otp));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(328.w, 44.h),
                        backgroundColor: const Color(0xff100E09),
                      ),
                      child: Text(
                        'Verify',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
                        ),
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
