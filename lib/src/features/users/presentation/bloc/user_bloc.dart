import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx_assessment/src/core/utils/result.dart';
import 'package:totalx_assessment/src/core/utils/utils.dart';
import 'package:totalx_assessment/src/features/users/domain/usecases/get_user_image.dart';

import '../../domain/models/user.dart';
import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser addUserUseCase;
  final GetUsers getUsers;
  final GetUserImage getUserImage;
  List<User> listOfUsers = [];
   AgeCategory selectedCategory = AgeCategory.all;

  UserBloc(
    this.addUserUseCase,
    this.getUsers,
    this.getUserImage,
  ) : super(UserInitial()) {
    on<AddUserEvent>(_onAddUser);
    on<GetUsersEvent>(_fetchUsers);
    on<PickImageEvent>(_onPickImage);
    on<SelectAgeCategoryEvent>(_returnUsersByAgeCategory);
    on<SearchTextEvent>(_handleSearchText);
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await addUserUseCase(
      User(
        id: generateUserUuid(),
        name: event.user.name,
        age: event.user.age,
        imagePath: event.user.imagePath,
      ),
    );

    if (result.statusCode == StatusCode.unExpectedError) {
      print(result.message);
      emit(UserError(message: 'Something went wrong'));
    } else if (result.statusCode == StatusCode.failure) {
      print(result.message);
      emit(UserError(message: 'Something went wrong'));
    } else if (result.statusCode == StatusCode.success) {
      emit(UserAdded());
    }
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<UserState> emit) async {
    try {
      var res = await getUserImage.call();
      if (res.statusCode == StatusCode.unExpectedError) {
        print(res.message);
        emit(UserError(message: 'Something went wrong'));
        print(res.message);
      } else if (res.statusCode == StatusCode.failure) {
        emit(NoUserFoundState());
      } else if (res.statusCode == StatusCode.success) {
        emit(ImagePickedState(res.data!));
      }
    } catch (e) {
      print(e.toString());
      emit(UserError(message: 'Something went wrong'));
    }
  }

  FutureOr<void> _fetchUsers(
      GetUsersEvent event, Emitter<UserState> emit) async {
    try {
      var res = await getUsers.call(0, 20);
      if (res.statusCode == StatusCode.unExpectedError) {
        print(res.message);
        emit(UserError(message: 'Something went wrong'));
        print(res.message);
      } else if (res.statusCode == StatusCode.failure) {
        emit(UserError(message: 'Something went wrong'));
      } else if (res.statusCode == StatusCode.success) {
        listOfUsers = res.data;
        emit(UserLoaded(res.data));
      }
    } catch (e) {
      print(e.toString());
      emit(UserError(message: 'Something went wrong'));
    }
  }

  FutureOr<void> _returnUsersByAgeCategory(
      SelectAgeCategoryEvent event, Emitter<UserState> emit) {
    try {
      if (listOfUsers.isNotEmpty) {
        selectedCategory = event.selectedCategory;
        emit(UserLoaded(
          listOfUsers.sortByAgeCategory(event.selectedCategory)));
      } else {
        emit(NoUserFoundState());
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  FutureOr<void> _handleSearchText(SearchTextEvent event, Emitter<UserState> emit) {
    try {
      var foundUsers = listOfUsers.where((user) => user.name.toLowerCase().trim().contains(event.searchString.toLowerCase().trim())).toList();
      if(foundUsers.isEmpty){
emit(NoUserFoundState());
      }else{
  emit(UserLoaded(foundUsers));
      }
    
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
