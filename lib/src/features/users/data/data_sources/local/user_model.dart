import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final int age;
  final String imagePath;

  const UserModel({required this.id, required this.name, required this.age, required this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'imagePath': imagePath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      imagePath: map['imagePath'],
    );
  }

  @override
  List<Object?> get props => [id, name, age, imagePath];

  
}

