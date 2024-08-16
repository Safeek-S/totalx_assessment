import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_assessment/src/core/assets/app_texts.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_bloc.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_event.dart';
import 'package:totalx_assessment/src/features/users/presentation/bloc/user_state.dart';
import 'package:totalx_assessment/src/features/users/presentation/widgets/add_user_dialog.dart';

import '../../domain/models/user.dart';
import '../widgets/age_category_bottom_sheet.dart';
import '../widgets/user_list.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final TextEditingController userNameInputController = TextEditingController();
  final TextEditingController userAgeInputController = TextEditingController();

  @override
  void dispose() {
    userAgeInputController.dispose();
    userNameInputController.dispose();
    super.dispose();
  }

  Future<void> _showBottomSheet(List<User> users) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        // Obtain the existing instance of UserBloc

        return AgeCategoryBottomSheet(users);
      },
    );
  }

  Future<void> showDialogBox() async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog.adaptive(
              content: AddUserDialogContent(
                  userNameInputController: userNameInputController,
                  userAgeInputController: userAgeInputController));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff100E09),
        shape: const CircleBorder(),
        onPressed: () async => showDialogBox(),
        child: Icon(
          Icons.add,
          color: whiteColor,
          size: 32.h,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff100E09),
        title: Row(
          children: [
            Icon(
              Icons.place,
              size: 17.w,
              color: whiteColor,
            ),
            3.horizontalSpace,
            Text(
              'Nilambur',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserAdded) {
                    context
                        .read<UserBloc>()
                        .add(GetUsersEvent(offset: 0, limit: 10));
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else if (state is UserLoaded || state is NoUserFoundState) {

                    return Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: TextField(
                                  onChanged: (value) {
                                    context
                                        .read<UserBloc>()
                                        .add(SearchTextEvent(value));
                                  },
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ).w,
                                    labelStyle: GoogleFonts.montserrat(
                                        color:  blackColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                    labelText: 'Search',
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: blackColor),
                                        borderRadius:
                                            BorderRadius.circular(36).w),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4).w),
                                    backgroundColor: const Color(0xff100E09),
                                    minimumSize: Size(32.w, 32.h)),
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: whiteColor
                                ),
                                onPressed: () async {
                                  if (state is UserLoaded) {
                                       await _showBottomSheet(state.users);
                                  }
                               
                                }),
                          ],
                        ),
                       
                       state is UserLoaded &&  state.users.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10)
                                        .w,
                                child: Column(
                                  children: [
                                    UserCard(
                                      users: state.users,
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),

                            state is NoUserFoundState ? Center(child: Text("No User Found"),): SizedBox.shrink()
                      ],
                    );
                  } else if (state is UserError) {
                    return const Center(child: Text('Something went wrong'));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
