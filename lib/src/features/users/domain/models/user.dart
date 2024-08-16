import 'package:equatable/equatable.dart';

import '../../../../core/utils/utils.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int age;
  final String? imagePath;

  const User({required this.id, required this.name, required this.age, required this.imagePath});

  @override
  List<Object?> get props => [id, name, age, imagePath];
}


extension UserSortExtension on List<User> {
  List<User> sortByAgeCategory(AgeCategory category) {
    switch (category) {
      case AgeCategory.elder:
        return where((user) => user.age > 60).toList();
      case AgeCategory.younger:
        return where((user) => user.age <= 60).toList();
      case AgeCategory.all:
        return this;
    }
  }
}
