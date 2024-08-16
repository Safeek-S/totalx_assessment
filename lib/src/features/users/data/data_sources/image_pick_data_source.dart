import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/result.dart';

class ImagePickerDataSource {
  final ImagePicker _picker = ImagePicker();

  Future<Result<String?>> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image?.path != null && image!.path.isNotEmpty
          ? Result(StatusCode.success, 'image path obtained', image.path)
          : Result(StatusCode.failure, 'unable to fetch image path', "");
    } catch (e) {
      return Result(StatusCode.unExpectedError, e.toString(), "");
    }
  }
}
