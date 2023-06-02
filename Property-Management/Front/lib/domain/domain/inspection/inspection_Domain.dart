import '../../../domain/inspection/inspection_description.dart';
import '../../../domain/inspection/inspection_name.dart';
import '../../../domain/inspection/inspection_address.dart';

class InspectionDomain {
  InspectionName name;
  InspectionDescription descrption;
  InspectionAddress address;
  InspectionId? id;


  InspectionDomain({
    required this.name,
    required this.descrption,
    required this.address,
    this.id
  });

}

class InspectionId {
  String id;
  InspectionId({required this.id});

  @override
  String toString() {
    return id.toString();
  }

}