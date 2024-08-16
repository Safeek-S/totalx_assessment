import 'package:uuid/uuid.dart';

extension MaskedPhoneNumber on String {
  String mask() {
    if (length >= 5) {
      return '${substring(0, 3)}${'*' * (length - 5)}${substring(length - 2)}';
    } else {
      return this; // Return the original string if it's too short
    }
  }
}

String generateUserUuid() {
  final uuid = Uuid();
  return 'user-${uuid.v4()}';
}

enum AgeCategory {
  all('All'),
  elder('Age: Elder'),
  younger('Age: Younger');

  final String sortCondition;
  const AgeCategory(this.sortCondition);

  @override
  String toString() {
    return sortCondition;
  }
}
