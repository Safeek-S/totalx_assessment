import '../../../../core/utils/result.dart';
import '../../data/data_sources/local/user_local_data_source.dart';

import '../../data/data_sources/local/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user.dart';


class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<Result<bool>> addUser(User user) async {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        age: user.age,
        imagePath: user.imagePath!,
      );
      var res = await localDataSource.addUser(userModel);
      return res;
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), false);
    }
  }

  @override
  Future<Result<List<User>>> getUsers(int offset, int limit) async {
    try {
      final res = await localDataSource.getUsers(offset, limit);

      if (res.statusCode == StatusCode.success) {
        final users = res.data
            .map((userModel) => User(
                  id: userModel.id,
                  name: userModel.name,
                  age: userModel.age,
                  imagePath: userModel.imagePath,
                ))
            .toList();
        return Result(res.statusCode, res.message, users);
      } else {
        return Result(res.statusCode, res.message, []);
      }
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), []);
    }
  }
  
  @override
  Future<Result<String?>> pickImage() async{
    try {
      var res = await localDataSource.pickImage();
      return res;
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), "");
    }
  }
}
