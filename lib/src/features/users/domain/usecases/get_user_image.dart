import '../../../../core/utils/result.dart';
import '../repositories/user_repository.dart';

class GetUserImage {
  final UserRepository repository;

  GetUserImage(this.repository);

  Future<Result<String?>> call() async {
    return await repository.pickImage();
  }
}
