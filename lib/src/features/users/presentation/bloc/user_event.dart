

import '../../../../core/utils/utils.dart';
import '../../domain/models/user.dart';

abstract class UserEvent {}

class GetUsersEvent extends UserEvent {
  final int offset;
  final int limit;

  GetUsersEvent({required this.offset, required this.limit});
}

class AddUserEvent extends UserEvent {
  final User user;

  AddUserEvent(this.user);
}
class PickImageEvent extends UserEvent {}
class SelectAgeCategoryEvent extends UserEvent {
  final AgeCategory selectedCategory;
  final List<User> users;

   SelectAgeCategoryEvent(this.selectedCategory,this.users);

  
  List<Object?> get props => [selectedCategory,users];
}
class SearchTextEvent extends UserEvent {
  final String searchString;


   SearchTextEvent(this.searchString);

  
  List<Object?> get props => [searchString];
}

