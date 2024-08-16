import '../../../../core/utils/result.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Result<List<User>>> call(int offset, int limit) async {
    return await repository.getUsers(offset, limit);
  }
}
