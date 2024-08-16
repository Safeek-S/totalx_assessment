import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/core/assets/app_texts.dart';

import '../../domain/models/user.dart';

class UserCard extends StatelessWidget {
  final List<User> users;

  const UserCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            color: whiteColor,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.w,
                backgroundImage: users[index].imagePath!.isEmpty? AssetImage(otpImagePath) :  FileImage( 
                 
                  File(users[index].imagePath!)),
                
              ),
              title: Text(
                users[index].name,
                style: GoogleFonts.montserrat(
                    fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Age: ${users[index].age}",
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
          );
        });
  }
}
