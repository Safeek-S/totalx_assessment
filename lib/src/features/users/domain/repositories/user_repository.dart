
import '../../../../core/utils/result.dart';
import '../models/user.dart';


abstract class UserRepository {
  Future<Result<bool>> addUser(User user);
  Future<Result<List<User>>> getUsers(int offset, int limit);
   Future<Result<String?>> pickImage();
}
