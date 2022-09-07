import 'package:csean_mobile/domain/enums/enum.dart';

extension GenderTypeExtensions on GenderType {
  String getDemoImage() {
    switch (this) {
      case GenderType.male:
        return 'assets/place-holder/128_4.png';
      case GenderType.female:
        return 'assets/place-holder/128_12.png';
      case GenderType.other:
        return 'assets/place-holder/128_6.png';
      case GenderType.notSet:
        return 'assets/place-holder/128_7.png';
      default:
        throw Exception('The provided gender type =$this is invalid');
    }
  }
}