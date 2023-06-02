import 'package:property/domain/upload/upload_address.dart';

import '../../../domain/upload/upload_Domain.dart';
import '../../../domain/upload/upload_description.dart';
import '../../../domain/upload/upload_price.dart';
import '../../../domain/inspection/inspection_address.dart';

class UploadValidator {
  String? uploadPriceValidator(String? value) {
    try {
      UploadPrice(uploadPrice: value!);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? uploadAddressValidator(String? value) {
    try {
     UploadAddress(uploadAddress: value);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? uploadDescriptionValidator(String? value) {
    try {
      UploadDescription(uploadDescription: value);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
