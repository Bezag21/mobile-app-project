import '../../../domain/inspection/inspection_Domain.dart';
import '../../../domain/inspection/inspection_description.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../domain/inspection/inspection_address.dart';

class inspectionValidator {
  String? inspectionNameValidator(String? value) {
    try {
      InspectionName(inspectionName: value!);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? inspectionAddressValidator(String? value) {
    try {
     InspectionAddress(inspectionAddress: value);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  String? inspectionDescriptionValidator(String? value) {
    try {
      InspectionDescription(inspectionDescription: value);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
