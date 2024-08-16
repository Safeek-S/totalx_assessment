// presentation/widgets/age_category_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_state.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/models/user.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class AgeCategoryBottomSheet extends StatelessWidget {
  final List<User> users;
  const AgeCategoryBottomSheet(this.users);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).w,
                  child: Text(
                    'Sort',
                    style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000)),
                  ),
                ), // Adding a title at the top
                ...AgeCategory.values.map((category) {
                  return RadioListTile<AgeCategory>(
                    title: Text(category.sortCondition),
                    value: category,
                    groupValue: context.read<UserBloc>().selectedCategory,
                    onChanged: (AgeCategory? value) {
                      if (value != null) {
                        BlocProvider.of<UserBloc>(context)
                            .add(SelectAgeCategoryEvent(value, users));
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
              ],
            )
          ],
        );
      },
    );
  }
}
