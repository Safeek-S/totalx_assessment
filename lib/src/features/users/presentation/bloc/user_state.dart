
import '../../../../core/utils/utils.dart';
import '../../domain/models/user.dart';

abstract class UserState {
  final bool isLoading;

  UserState({this.isLoading = false});
}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  UserLoading() : super(isLoading: true);
}

class UserLoaded extends UserState {

  final List<User> users;

  UserLoaded( this.users ) : super(isLoading: false);
}
class ImagePickedState extends UserState {
  final String imagePath;

  ImagePickedState(this.imagePath);
}


class UserAdded extends UserState {}

class UserError extends UserState {
  final String? message;

  UserError({this.message}) : super(isLoading: false);
}

class UsersFilteredByAgeState extends UserState {
  final AgeCategory selectedCategory;
  final List<User> filteredUsers;


   
   UsersFilteredByAgeState(this.selectedCategory, this.filteredUsers);

  List<Object?> get props => [selectedCategory, filteredUsers];
}


class NoUserFoundState extends UserState{
  
}