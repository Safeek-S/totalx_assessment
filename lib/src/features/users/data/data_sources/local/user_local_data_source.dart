import '../../../../../core/utils/result.dart';
import 'user_model.dart';

abstract class UserLocalDataSource {
  Future<Result<bool>> addUser(UserModel user);
  Future<Result<List<UserModel>>> getUsers(int offset, int limit);
    Future<Result<String?>> pickImage();
}