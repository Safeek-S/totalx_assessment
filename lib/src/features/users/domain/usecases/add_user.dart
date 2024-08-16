
import '../../../../core/utils/result.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';


class AddUser {
  final UserRepository repository;

  AddUser(this.repository);


  Future<Result<bool>> call(User user) async {
    return await repository.addUser(user);
  }
}
